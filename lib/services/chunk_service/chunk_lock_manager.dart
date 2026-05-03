import 'package:synchronized/synchronized.dart';

class ChunkLockManager {
  final Map<String, Lock> _locks = {};

  Lock _getLock(String chunkId) {
    return _locks.putIfAbsent(chunkId, () => Lock());
  }

  Future<T> withChunkLock<T>(String chunkId, Future<T> Function() computation) {
    final lock = _getLock(chunkId);
    return lock.synchronized(computation);
  }
}
