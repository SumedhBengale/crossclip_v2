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
    var newref = await ref.child('users/$uid/textClipboard').push();
    await newref.set({'text': textController.text});
    // await ref.child('users/$uid').update({
    //   "name": "John",
    //   "age": 18,
    //   "address": {"line1": "100 View"}
    // });
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
                child: BlocConsumer<TextClipboardCubit, TextClipboardState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return MasonryGridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width ~/ 450.toInt() > 0
                              ? MediaQuery.of(context).size.width ~/ 450.toInt()
                              : 1,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: 200,
                      itemBuilder: (context, index) {
                        return const TextCard();
                      },
                    );
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
