import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/rate_limiter/rate_limiter.dart';

void main() {
  group('RateLimiter', () {
    test('should allow requests within the limit', () async {
      final rateLimiter = RateLimiter(maxRequests: 5, timeWindow: Duration(seconds: 1));
      for (int i = 0; i < 5; i++) {
        expect(await rateLimiter.isAllowed(), true);
      }
      expect(await rateLimiter.isAllowed(), false);
    });

    test('should reset the counter after the time window', () async {
      final rateLimiter = RateLimiter(maxRequests: 1, timeWindow: Duration(milliseconds: 500));
      expect(await rateLimiter.isAllowed(), true);
      expect(await rateLimiter.isAllowed(), false);
      await Future.delayed(Duration(milliseconds: 500));
      expect(await rateLimiter.isAllowed(), true);
    });
  });
}
