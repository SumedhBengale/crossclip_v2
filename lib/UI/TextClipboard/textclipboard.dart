import 'package:crossclip_v2/UI/TextClipboard/textcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TextClipboard extends StatefulWidget {
  const TextClipboard({super.key});

  @override
  State<TextClipboard> createState() => _TextClipboardState();
}

class _TextClipboardState extends State<TextClipboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MasonryGridView.count(
        crossAxisCount: MediaQuery.of(context).size.width ~/ 450.toInt() > 0
            ? MediaQuery.of(context).size.width ~/ 450.toInt()
            : 1,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: 6,
        itemBuilder: (context, index) {
          return const TextCard();
        },
      ),
    );
  }
}
