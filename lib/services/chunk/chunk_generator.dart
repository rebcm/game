import 'dart:isolate';
import 'package:rebcm/models/chunk.dart';
import 'package:rebcm/services/terrain_generator.dart';

class ChunkGenerator {
  static Future<Chunk> generateChunk(int x, int z) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(_generateChunkIsolate, [x, z, receivePort.sendPort]);
    final chunk = await receivePort.first;
    isolate.kill();
    return chunk;
  }

  static void _generateChunkIsolate(List<dynamic> args) {
    final x = args[0];
    final z = args[1];
    final sendPort = args[2];
    final chunk = TerrainGenerator.generateChunk(x, z);
    sendPort.send(chunk);
  }
}
