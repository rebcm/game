import 'package:passdriver/features/retry_logic/domain/retry_policy.dart';

class RetryRepository {
  final RetryPolicy _retryPolicy;

  RetryRepository(this._retryPolicy);

  Future<void> retryOperation(Future<void> Function() operation) async {
    await _retryPolicy.retry(operation);
  }
}
