part of 'media_clipboard_cubit.dart';

@immutable
abstract class MediaClipboardState {}

class MediaClipboardInitial extends MediaClipboardState {}

class MediaClipboardUpdate extends MediaClipboardState {
  final Event event;
  MediaClipboardUpdate(this.event);
}

class MediaClipboardDelete extends MediaClipboardState {
  final Event event;
  MediaClipboardDelete(this.event);
}
