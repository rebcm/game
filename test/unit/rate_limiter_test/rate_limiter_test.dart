import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/rate_limiter/rate_limiter.dart';

void main() {
  group('RateLimiter', () {
    test('allows requests within the limit', () {
      final rateLimiter = RateLimiter(maxRequests: 5, timeWindow: Duration(seconds: 1));
      for (var i = 0; i < 5; i++) {
        expect(rateLimiter.isAllowed('test_key'), true);
      }
      expect(rateLimiter.isAllowed('test_key'), false);
    });

    test('resets count after time window', () async {
      final rateLimiter = RateLimiter(maxRequests: 1, timeWindow: Duration(milliseconds: 500));
      expect(rateLimiter.isAllowed('test_key'), true);
      expect(rateLimiter.isAllowed('test_key'), false);
      await Future.delayed(Duration(milliseconds: 500));
      expect(rateLimiter.isAllowed('test_key'), true);
    });
  });
}
