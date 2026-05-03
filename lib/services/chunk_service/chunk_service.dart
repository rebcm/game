import 'package:game/services/chunk_service/chunk_rate_limiter.dart';

class ChunkService {
  final ChunkRateLimiter _rateLimiter;

  ChunkService({required ChunkRateLimiter rateLimiter}) : _rateLimiter = rateLimiter;

  Future<void> fetchChunk(String chunkId) async {
    if (_rateLimiter.isAllowed(chunkId)) {
      // Implement chunk fetching logic here
      print('Fetching chunk: $chunkId');
    } else {
      print('Rate limit exceeded for chunk: $chunkId');
    }
  }
}
