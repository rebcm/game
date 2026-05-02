import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoggingProvider with ChangeNotifier {
  final Logger _logger = Logger();

  void logInfo(String message) => _logger.i(message);
  void logError(String message, dynamic error) => _logger.e(message, error);
}
