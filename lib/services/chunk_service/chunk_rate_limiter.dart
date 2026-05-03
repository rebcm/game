import 'package:flutter/foundation.dart';

class ChunkRateLimiter with ChangeNotifier {
  final Map<String, DateTime> _requests = {};
  final Duration _minInterval;

  ChunkRateLimiter({required Duration minInterval}) : _minInterval = minInterval;

  bool isAllowed(String chunkId) {
    final now = DateTime.now();
    final lastRequest = _requests[chunkId];

    if (lastRequest == null || now.difference(lastRequest) >= _minInterval) {
      _requests[chunkId] = now;
      return true;
    }
    return false;
  }

  void reset(String chunkId) {
    _requests.remove(chunkId);
    notifyListeners();
  }
}
