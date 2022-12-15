import 'package:bloc/bloc.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:meta/meta.dart';

part 'media_clipboard_state.dart';

class MediaClipboardCubit extends Cubit<MediaClipboardState> {
  MediaClipboardCubit() : super(MediaClipboardInitial());

  void getStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase(
            databaseURL:
                'https://crossclip-271415-default-rtdb.firebaseio.com/')
        .reference()
        .child('users/$uid/mediaClipboard')
        .onValue
        .listen((event) {
      emit(MediaClipboardUpdate(event));
    });
  }

  void deleteMedia(String key) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase(
            databaseURL:
                'https://crossclip-271415-default-rtdb.firebaseio.com/')
        .reference()
        .child('users/$uid/mediaClipboard/$key')
        .remove();
  }
}
