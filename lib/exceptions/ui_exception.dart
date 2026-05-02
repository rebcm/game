import 'package:rebcm/exceptions/game_exception.dart';

class UiException extends GameException {
  UiException(String message) : super(message);

  @override
  String toString() {
    return 'UiException: $message';
  }
}
