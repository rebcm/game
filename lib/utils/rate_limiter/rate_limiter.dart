import 'package:http/http.dart' as http;

class RateLimiter {
  final int maxRequests;
  final Duration timeWindow;
  final Map<String, List<DateTime>> _requests = {};

  RateLimiter({required this.maxRequests, required this.timeWindow});

  Future<bool> isAllowed(String key) async {
    final now = DateTime.now();
    _requests[key] = _requests[key]?.where((time) => now.difference(time) < timeWindow).toList() ?? [];
    if (_requests[key]!.length >= maxRequests) {
      return false;
    }
    _requests[key]!.add(now);
    return true;
  }
}
