import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_service/chunk_rate_limiter.dart';
import 'package:game/services/chunk_service/chunk_service.dart';

void main() {
  group('ChunkService', () {
    test('fetches chunk when rate limit is not exceeded', () async {
      final rateLimiter = ChunkRateLimiter(minInterval: Duration(seconds: 1));
      final chunkService = ChunkService(rateLimiter: rateLimiter);
      await chunkService.fetchChunk('chunk1');
      // Verify fetch logic was called
    });

    test('does not fetch chunk when rate limit is exceeded', () async {
      final rateLimiter = ChunkRateLimiter(minInterval: Duration(seconds: 1));
      final chunkService = ChunkService(rateLimiter: rateLimiter);
      await chunkService.fetchChunk('chunk1');
      await chunkService.fetchChunk('chunk1');
      // Verify fetch logic was not called the second time
    });
  });
}
