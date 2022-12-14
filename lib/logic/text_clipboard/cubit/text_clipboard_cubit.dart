import 'package:bloc/bloc.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:meta/meta.dart';

part 'text_clipboard_state.dart';

class TextClipboardCubit extends Cubit<TextClipboardState> {
  TextClipboardCubit() : super(TextClipboardInitial());
  void getStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase(
            databaseURL:
                'https://crossclip-271415-default-rtdb.firebaseio.com/')
        .reference()
        .child('users/$uid/textClipboard')
        .onValue
        .listen((event) {
      emit(TextClipboardUpdate(event));
    });
  }

  void deleteText(String key) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase(
            databaseURL:
                'https://crossclip-271415-default-rtdb.firebaseio.com/')
        .reference()
        .child('users/$uid/textClipboard/$key')
        .remove();
  }
}
