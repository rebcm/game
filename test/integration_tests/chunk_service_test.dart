import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_service/chunk_service.dart';
import 'package:game/utils/rate_limiter/rate_limiter.dart';

void main() {
  group('ChunkService', () {
    test('should return chunk data within the rate limit', () async {
      final rateLimiter = RateLimiter(maxRequests: 10, timeWindow: Duration(seconds: 1));
      final chunkService = ChunkService(rateLimiter: rateLimiter);
      final response = await chunkService.getChunk(0, 0);
      expect(response.statusCode, 200);
    });

    test('should return 429 when rate limit is exceeded', () async {
      final rateLimiter = RateLimiter(maxRequests: 1, timeWindow: Duration(seconds: 1));
      final chunkService = ChunkService(rateLimiter: rateLimiter);
      await chunkService.getChunk(0, 0);
      final response = await chunkService.getChunk(0, 0);
      expect(response.statusCode, 429);
    });
  });
}
