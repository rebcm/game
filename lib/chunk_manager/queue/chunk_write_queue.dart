import 'dart:async';
import 'package:game/chunk_manager/chunk_lock_manager.dart';
import 'package:game/chunk_manager/models/chunk_write_request.dart';

class ChunkWriteQueue {
  final ChunkLockManager _lockManager;
  final StreamController<ChunkWriteRequest> _queueController;
  late StreamSubscription<ChunkWriteRequest> _subscription;

  ChunkWriteQueue(this._lockManager) : _queueController = StreamController<ChunkWriteRequest>.broadcast() {
    _subscription = _queueController.stream.listen(_processWriteRequest);
  }

  void addWriteRequest(ChunkWriteRequest request) {
    _queueController.add(request);
  }

  Future<void> _processWriteRequest(ChunkWriteRequest request) async {
    await _lockManager.acquireLock(request.chunkId);
    try {
      // Implement the actual write logic here
      print('Writing to chunk ${request.chunkId}: ${request.data}');
    } finally {
      _lockManager.releaseLock(request.chunkId);
    }
  }

  void dispose() {
    _subscription.cancel();
    _queueController.close();
  }
}
