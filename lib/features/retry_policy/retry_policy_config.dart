class RetryPolicyConfig {
  final RetryPolicy policy;
  final int maxAttempts;

  RetryPolicyConfig({required this.policy, required this.maxAttempts});
}
