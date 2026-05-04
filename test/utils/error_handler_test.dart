import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/error_handler.dart';

void main() {
  test('handleError handles error and stack trace', () {
    final error = Exception('Test error');
    final stackTrace = StackTrace.current;
    ErrorHandler.handleError(error, stackTrace);
    // Verify that it prints the error details and sends the report
  });
}
