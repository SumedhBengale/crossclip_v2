import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextClipboard extends StatefulWidget {
  const TextClipboard({super.key});

  @override
  State<TextClipboard> createState() => _TextClipboardState();
}

class _TextClipboardState extends State<TextClipboard> {
  @override
  Widget build(BuildContext context) {
    return const Text("Text Clipboard");
  }
}
