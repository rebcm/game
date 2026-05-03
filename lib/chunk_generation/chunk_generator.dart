import 'dart:isolate';
import 'package:game/utils/isolate_guard/isolate_guard.dart';

class ChunkGenerator {
  static Future<void> generateChunk(int chunkX, int chunkZ) async {
    final receivePort = ReceivePort();
    final isolate = await IsolateGuard.spawn(_generateChunk, [chunkX, chunkZ, receivePort.sendPort]);
    await receivePort.first;
    receivePort.close();
  }

  static void _generateChunk(List<dynamic> args) {
    final chunkX = args[0];
    final chunkZ = args[1];
    final sendPort = args[2];
    // Chunk generation logic here
    sendPort.send(null);
  }
}
