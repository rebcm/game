import 'package:game/services/isolate_guard/isolate_guard.dart';

class ChunkGenerator {
  static Future<void> generateChunk(int x, int z) async {
    await IsolateGuard.spawnIsolate(
      () async {
        // Chunk generation logic here
      },
      () {
        // On complete logic here
      },
    );
  }
}
