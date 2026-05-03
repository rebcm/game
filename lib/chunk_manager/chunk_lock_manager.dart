import 'dart:async';

class ChunkLockManager {
  final Map<String, Completer<void>> _locks = {};

  Future<void> acquireLock(String chunkId) async {
    while (_locks.containsKey(chunkId)) {
      await _locks[chunkId]!.future;
    }
    final completer = Completer<void>();
    _locks[chunkId] = completer;
  }

  void releaseLock(String chunkId) {
    if (_locks.containsKey(chunkId)) {
      _locks[chunkId]!.complete();
      _locks.remove(chunkId);
    }
  }
}
