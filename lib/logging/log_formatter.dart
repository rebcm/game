import 'package:intl/intl.dart';

class LogFormatter {
  static String format(String message, DateTime timestamp, String level) {
    return '${DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp)} [$level] $message';
  }
}
