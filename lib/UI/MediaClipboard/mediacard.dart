import 'package:crossclip_v2/logic/media_clipboard/cubit/media_clipboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaCard extends StatefulWidget {
  final String text;
  final String id;
  const MediaCard(this.text, this.id, {super.key});
  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {
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
              Expanded(
                child: Text(widget.text.toString(),
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
                onPressed: () => {
                  BlocProvider.of<MediaClipboardCubit>(context)
                      .deleteMedia(widget.id)
                },
                child: const Icon(Icons.delete),
              )
            ],
          ),
        ));
  }
}
