import 'package:flutter/foundation.dart';

class RateLimiter {
  final int _maxRequests;
  final Duration _timeWindow;
  final Map<String, List<DateTime>> _requestTimestamps = {};

  RateLimiter({required int maxRequests, required Duration timeWindow})
      : _maxRequests = maxRequests,
        _timeWindow = timeWindow;

  bool isAllowed(String key) {
    final now = DateTime.now();
    final timestamps = _requestTimestamps[key] ?? [];

    _requestTimestamps[key] = timestamps
      ..removeWhere((timestamp) => now.difference(timestamp) > _timeWindow)
      ..add(now);

    return _requestTimestamps[key]!.length <= _maxRequests;
  }
}
