import 'package:http/http.dart' as http;
import 'package:game/utils/rate_limiter/rate_limiter.dart';

class ChunkService {
  final RateLimiter _rateLimiter;

  ChunkService({required RateLimiter rateLimiter}) : _rateLimiter = rateLimiter;

  Future<http.Response> getChunk(int x, int z) async {
    if (!await _rateLimiter.isAllowed()) {
      return http.Response('Rate limit exceeded', 429);
    }
    // Implement the logic to get the chunk here
    // For now, it just returns a dummy response
    return http.Response('Chunk data', 200);
  }
}
