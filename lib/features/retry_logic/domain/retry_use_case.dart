import 'package:passdriver/features/retry_logic/domain/retry_policy.dart';

class RetryUseCase {
  final RetryPolicy _retryPolicy;

  RetryUseCase(this._retryPolicy);

  Future<void> execute(Future<void> Function() operation) async {
    await _retryPolicy.retry(operation);
  }
}
