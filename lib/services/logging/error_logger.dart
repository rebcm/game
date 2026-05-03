import 'package:http/http.dart' as http;
import 'package:game/exceptions/authentication_exception.dart';
import 'package:game/exceptions/infrastructure_exception.dart';
import 'package:game/exceptions/payload_exception.dart';

class ErrorLogger {
  static void logError(Object error, StackTrace stackTrace) {
    if (error is AuthenticationException) {
      _logAuthenticationError(error, stackTrace);
    } else if (error is InfrastructureException) {
      _logInfrastructureError(error, stackTrace);
    } else if (error is PayloadException) {
      _logPayloadError(error, stackTrace);
    } else {
      _logGenericError(error, stackTrace);
    }
  }

  static void _logAuthenticationError(AuthenticationException error, StackTrace stackTrace) {
    print('Authentication Error: ${error.message}');
    print(stackTrace);
  }

  static void _logInfrastructureError(InfrastructureException error, StackTrace stackTrace) {
    print('Infrastructure Error: ${error.message}');
    print(stackTrace);
  }

  static void _logPayloadError(PayloadException error, StackTrace stackTrace) {
    print('Payload Error: ${error.message}');
    print(stackTrace);
  }

  static void _logGenericError(Object error, StackTrace stackTrace) {
    print('Generic Error: $error');
    print(stackTrace);
  }
}
