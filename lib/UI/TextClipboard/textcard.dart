import 'package:flutter/material.dart';

class TextCard extends StatefulWidget {
  const TextCard({super.key});

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text("Text Card",
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Icon(Icons.copy),
                ),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Icon(Icons.delete),
              )
            ],
          ),
        ));
  }
}
