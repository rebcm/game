import 'dart:isolate';
import 'package:game/services/chunk_manager/chunk_isolate_guard.dart';

class ChunkManager {
  final ChunkIsolateGuard _isolateGuard = ChunkIsolateGuard();

  Future<void> generateChunk() async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(_generateChunkIsolate, receivePort.sendPort);
    _isolateGuard.addIsolate(isolate);
    // Implement chunk generation logic here
  }

  static void _generateChunkIsolate(SendPort sendPort) {
    // Implement isolate logic here
    sendPort.send(null);
  }

  void dispose() {
    _isolateGuard.killAll();
  }
}
