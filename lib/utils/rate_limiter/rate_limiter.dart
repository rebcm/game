import 'package:flutter/foundation.dart';

class RateLimiter {
  final int maxRequests;
  final Duration timeWindow;
  final Map<String, List<DateTime>> _requests = {};

  RateLimiter({required this.maxRequests, required this.timeWindow});

  bool isAllowed(String key) {
    final now = DateTime.now();
    _requests[key] = _requests[key]?.where((time) => now.difference(time) < timeWindow).toList() ?? [];
    if (_requests[key]!.length < maxRequests) {
      _requests[key]!.add(now);
      return true;
    }
    return false;
  }
}
