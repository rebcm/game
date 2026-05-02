import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/retry_policy/retry_policy.dart';

void main() {
  test('shouldRetry retorna true para timeout', () {
    final retryPolicy = RetryPolicy();
    expect(retryPolicy.shouldRetry('timeout'), true);
  });

  test('shouldRetry retorna true para connection_error', () {
    final retryPolicy = RetryPolicy();
    expect(retryPolicy.shouldRetry('connection_error'), true);
  });

  test('shouldRetry retorna false para outros erros', () {
    final retryPolicy = RetryPolicy();
    expect(retryPolicy.shouldRetry('outro_erro'), false);
  });
}
