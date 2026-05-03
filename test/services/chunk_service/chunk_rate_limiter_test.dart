import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_service/chunk_rate_limiter.dart';

void main() {
  group('ChunkRateLimiter', () {
    test('allows initial request', () {
      final rateLimiter = ChunkRateLimiter(minInterval: Duration(seconds: 1));
      expect(rateLimiter.isAllowed('chunk1'), true);
    });

    test('denies request within minInterval', () {
      final rateLimiter = ChunkRateLimiter(minInterval: Duration(seconds: 1));
      rateLimiter.isAllowed('chunk1');
      expect(rateLimiter.isAllowed('chunk1'), false);
    });

    test('allows request after minInterval', () async {
      final rateLimiter = ChunkRateLimiter(minInterval: Duration(milliseconds: 500));
      rateLimiter.isAllowed('chunk1');
      await Future.delayed(Duration(milliseconds: 500));
      expect(rateLimiter.isAllowed('chunk1'), true);
    });

    test('resets request tracking', () {
      final rateLimiter = ChunkRateLimiter(minInterval: Duration(seconds: 1));
      rateLimiter.isAllowed('chunk1');
      rateLimiter.reset('chunk1');
      expect(rateLimiter.isAllowed('chunk1'), true);
    });
  });
}
