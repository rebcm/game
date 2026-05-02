import 'package:flutter/material.dart';
import 'package:passdriver/features/retry_policy/retry_policy_enum.dart';

class RetryPolicyProvider with ChangeNotifier {
  RetryPolicyConfig _config = RetryPolicyConfig(policy: RetryPolicy.retry, maxRetries: 3);

  RetryPolicyConfig get config => _config;

  void updateConfig(RetryPolicyConfig newConfig) {
    _config = newConfig;
    notifyListeners();
  }
}
