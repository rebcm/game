import 'package:http/http.dart' as http;

class RateLimiter {
  final int maxRequests;
  final Duration timeWindow;
  final List<DateTime> requestTimestamps = [];

  RateLimiter({required this.maxRequests, required this.timeWindow});

  Future<bool> isAllowed() async {
    final now = DateTime.now();
    requestTimestamps.removeWhere((timestamp) => now.difference(timestamp) > timeWindow);
    if (requestTimestamps.length >= maxRequests) {
      return false;
    }
    requestTimestamps.add(now);
    return true;
  }
}
