import 'package:crossclip_v2/UI/TextClipboard/textcard.dart';
import 'package:crossclip_v2/logic/text_clipboard/cubit/text_clipboard_cubit.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TextClipboard extends StatefulWidget {
  const TextClipboard({super.key});

  @override
  State<TextClipboard> createState() => _TextClipboardState();
}

class _TextClipboardState extends State<TextClipboard> {
  TextEditingController textController = TextEditingController();

  void addToTextClipboard() async {
    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                'https://crossclip-271415-default-rtdb.firebaseio.com/')
        .reference();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var newref = ref.child('users/$uid/textClipboard').push();
    await newref.set({'text': textController.text});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextClipboardCubit(),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10, bottom: 60),
                child: BlocBuilder<TextClipboardCubit, TextClipboardState>(
                  builder: (context, state) {
                    if (state is TextClipboardUpdate) {
                      if (state.event.snapshot.value == null) {
                        return const Center(
                            child: Text("No Text in Clipboard"));
                      } else {
                        Map<String, dynamic> data = state.event.snapshot.value;
                        List text = [];
                        List ids = [];
                        for (var key in data.keys) {
                          text.add(data[key]['text']);
                          ids.add(key);
                        }
                        return MasonryGridView.count(
                          crossAxisCount: MediaQuery.of(context).size.width ~/
                                      450.toInt() >
                                  0
                              ? MediaQuery.of(context).size.width ~/ 450.toInt()
                              : 1,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: state.event.snapshot.value.length,
                          itemBuilder: (context, index) {
                            return TextCard(text[index], ids[index]);
                          },
                        );
                      }
                    } else {
                      BlocProvider.of<TextClipboardCubit>(context).getStream();
                      return const Center(
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: SizedBox(
                                height: 200,
                                width: 400,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Add Text to Clipboard",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Enter Text',
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            addToTextClipboard();
                                          },
                                          child: const Text("Add to Clipboard"))
                                    ]),
                              ),
                            ));
                  },
                  label: const Text("Add Text to Clipboard")),
            ),
          ),
        ],
      ),
    );
  }
}
