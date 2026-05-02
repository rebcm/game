import 'package:passdriver/features/retry_policy/retry_policy_enum.dart';\n
class RetryPolicyService {
  RetryPolicyConfig getRetryPolicyConfig(String errorType) {
    switch (errorType) {
      case 'network_error':
        return RetryPolicyConfig(policy: RetryPolicy.retry, maxAttempts: 3);
      case 'server_error':
        return RetryPolicyConfig(policy: RetryPolicy.failFast, maxAttempts: 1);
      default:
        return RetryPolicyConfig(policy: RetryPolicy.retry, maxAttempts: 2);
    }
  }
}
