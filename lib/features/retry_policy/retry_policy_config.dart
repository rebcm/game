class RetryPolicyConfig {
  final RetryPolicy policy;
  final int maxRetries;

  RetryPolicyConfig({required this.policy, required this.maxRetries});
}
