import 'package:test/test.dart';
import 'package:game/services/logging/error_logger.dart';
import 'package:game/exceptions/authentication_exception.dart';
import 'package:game/exceptions/infrastructure_exception.dart';
import 'package:game/exceptions/payload_exception.dart';

void main() {
  test('logs authentication error', () {
    expect(() => ErrorLogger.logError(AuthenticationException('test'), StackTrace.empty), returnsNormally);
  });

  test('logs infrastructure error', () {
    expect(() => ErrorLogger.logError(InfrastructureException('test'), StackTrace.empty), returnsNormally);
  });

  test('logs payload error', () {
    expect(() => ErrorLogger.logError(PayloadException('test'), StackTrace.empty), returnsNormally);
  });

  test('logs generic error', () {
    expect(() => ErrorLogger.logError(Exception('test'), StackTrace.empty), returnsNormally);
  });
}
