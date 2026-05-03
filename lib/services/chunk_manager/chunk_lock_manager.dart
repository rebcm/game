import 'dart:collection';

class ChunkLockManager {
  final Map<String, Queue<ChunkOperation>> _chunkQueues = {};
  final Map<String, bool> _chunkLocks = {};

  void enqueueOperation(String chunkId, ChunkOperation operation) {
    if (!_chunkQueues.containsKey(chunkId)) {
      _chunkQueues[chunkId] = Queue();
    }
    _chunkQueues[chunkId]!.add(operation);
    _processQueue(chunkId);
  }

  void _processQueue(String chunkId) {
    if (_chunkLocks[chunkId] ?? false) return;
    if (_chunkQueues[chunkId]?.isEmpty ?? true) return;

    _chunkLocks[chunkId] = true;
    final operation = _chunkQueues[chunkId]!.removeFirst();
    operation.execute().whenComplete(() {
      _chunkLocks[chunkId] = false;
      _processQueue(chunkId);
    });
  }
}

class ChunkOperation {
  final Function _operation;

  ChunkOperation(this._operation);

  Future<void> execute() async {
    await _operation();
  }
}
