import 'package:game/utils/rate_limiter/rate_limiter.dart';

class ChunkService {
  final RateLimiter _rateLimiter;

  ChunkService({required RateLimiter rateLimiter})
      : _rateLimiter = rateLimiter;

  Future<void> fetchChunk(String chunkId) async {
    if (!_rateLimiter.isAllowed(chunkId)) {
      throw Exception('Rate limit exceeded for chunk $chunkId');
    }
    // Implement chunk fetching logic here
  }
}
