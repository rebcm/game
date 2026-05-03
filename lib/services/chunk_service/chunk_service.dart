import 'package:game/utils/rate_limiter/rate_limiter.dart';

class ChunkService {
  final RateLimiter _rateLimiter;

  ChunkService(this._rateLimiter);

  Future<void> fetchChunk(String chunkId) async {
    if (_rateLimiter.isAllowed(chunkId)) {
      // Implement chunk fetching logic here
    } else {
      // Handle rate limit exceeded
    }
  }
}
