import 'dart:isolate';
import 'package:rebcm/services/isolate_guard/isolate_guard.dart';

class ChunkGenerationService {
  static const String _isolateId = 'chunkGenerationIsolate';

  Future<void> generateChunk(SendPort sendPort) async {
    await IsolateGuard.spawnIsolate(_isolateId, _generateChunkIsolate, sendPort);
  }

  static void _generateChunkIsolate(SendPort sendPort) {
    // Implement chunk generation logic here
    // Make sure to send the result back to the main isolate using sendPort
    sendPort.send(null); // Example: sending null back to the main isolate
  }

  void cancelChunkGeneration() {
    IsolateGuard.killIsolate(_isolateId);
  }
}
