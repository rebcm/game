import 'dart:isolate';
import 'package:rebcm/models/chunk/chunk.dart';

class ChunkGenerator {
  static Future<Chunk> generateChunk(int x, int z) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_generateChunkIsolate, [x, z, receivePort.sendPort]);
    return await receivePort.first;
  }

  static void _generateChunkIsolate(List<dynamic> args) {
    final x = args[0];
    final z = args[1];
    final sendPort = args[2];
    // Implement chunk generation logic here
    final chunk = Chunk(x: x, z: z); // Replace with actual generation logic
    sendPort.send(chunk);
  }
}
