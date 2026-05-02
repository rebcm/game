import 'package:flutter/material.dart';
import 'package:passdriver/features/error_handling/error_handling_matrix.dart';

class ErrorHandlingProvider with ChangeNotifier {
  final ErrorHandlingMatrix _matrix = ErrorHandlingMatrix();

  bool shouldRetry(Exception exception) => _matrix.shouldRetry(exception);
}
