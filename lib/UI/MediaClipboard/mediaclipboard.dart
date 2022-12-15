import 'package:crossclip_v2/UI/MediaClipboard/mediacard.dart';
import 'package:crossclip_v2/logic/media_clipboard/cubit/media_clipboard_cubit.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MediaClipboard extends StatefulWidget {
  const MediaClipboard({super.key});

  @override
  State<MediaClipboard> createState() => _MediaClipboardState();
}

class _MediaClipboardState extends State<MediaClipboard> {
  TextEditingController MediaController = TextEditingController();

  void addToMediaClipboard() async {
    DatabaseReference ref = FirebaseDatabase(
            databaseURL:
                'https://crossclip-271415-default-rtdb.firebaseio.com/')
        .reference();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var newref = ref.child('users/$uid/mediaClipboard').push();
    await newref.set({'Media': MediaController.text});
  }

  @override
  Widget build(BuildContext conMedia) {
    return BlocProvider(
      create: (conMedia) => MediaClipboardCubit(),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(conMedia).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 10, left: 10, bottom: 60),
                child: BlocBuilder<MediaClipboardCubit, MediaClipboardState>(
                  builder: (conMedia, state) {
                    if (state is MediaClipboardUpdate) {
                      if (state.event.snapshot.value == null) {
                        return const Center(
                            child: Text("No Media in Clipboard"));
                      } else {
                        Map<String, dynamic> data = state.event.snapshot.value;
                        List Media = [];
                        List ids = [];
                        for (var key in data.keys) {
                          Media.add(data[key]['Media']);
                          ids.add(key);
                        }
                        return MasonryGridView.count(
                          crossAxisCount: MediaQuery.of(conMedia).size.width ~/
                                      450.toInt() >
                                  0
                              ? MediaQuery.of(conMedia).size.width ~/
                                  450.toInt()
                              : 1,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: state.event.snapshot.value.length,
                          itemBuilder: (conMedia, index) {
                            return MediaCard(Media[index], ids[index]);
                          },
                        );
                      }
                    } else {
                      BlocProvider.of<MediaClipboardCubit>(conMedia)
                          .getStream();
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
            width: MediaQuery.of(conMedia).size.width,
            child: Center(
              child: FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                        context: conMedia,
                        builder: (conMedia) => Dialog(
                              child: SizedBox(
                                height: 200,
                                width: 400,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Add Media to Clipboard",
                                          style: Theme.of(conMedia)
                                              .textTheme
                                              .headlineSmall),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          controller: MediaController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Enter Media',
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            addToMediaClipboard();
                                          },
                                          child: const Text("Add to Clipboard"))
                                    ]),
                              ),
                            ));
                  },
                  label: const Text("Add Media to Clipboard")),
            ),
          ),
        ],
      ),
    );
  }
}
