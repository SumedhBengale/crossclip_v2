part of 'text_clipboard_cubit.dart';

@immutable
abstract class TextClipboardState {}

class TextClipboardInitial extends TextClipboardState {}

class TextClipboardUpdate extends TextClipboardState {
  final Event event;
  TextClipboardUpdate(this.event);
}

class TextClipboardDelete extends TextClipboardState {
  final Event event;
  TextClipboardDelete(this.event);
}
