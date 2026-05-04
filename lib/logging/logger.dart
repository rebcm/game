import 'package:game/logging/log_formatter.dart';

class Logger {
  static void log(String message, {String level = 'INFO'}) {
    print(LogFormatter.format(message, DateTime.now(), level));
  }

  static void error(String message, {dynamic error}) {
    log('$message: $error', level: 'ERROR');
  }
}
