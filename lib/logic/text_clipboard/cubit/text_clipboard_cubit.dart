import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_clipboard_state.dart';

class TextClipboardCubit extends Cubit<TextClipboardState> {
  TextClipboardCubit() : super(TextClipboardInitial());
}
