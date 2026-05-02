import 'package:flutter_test/flutter_test.dart';\n
import 'package:passdriver/features/retry_policy/retry_policy_service.dart';\n
void main() {
  test('getRetryPolicyConfig returns correct config for network error', () {
    final service = RetryPolicyService();
    final config = service.getRetryPolicyConfig('network_error');
    expect(config.policy, RetryPolicy.retry);
    expect(config.maxAttempts, 3);
  });

  test('getRetryPolicyConfig returns correct config for server error', () {
    final service = RetryPolicyService();
    final config = service.getRetryPolicyConfig('server_error');
    expect(config.policy, RetryPolicy.failFast);
    expect(config.maxAttempts, 1);
  });
}
