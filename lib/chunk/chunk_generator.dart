import 'package:rebcm/services/isolate_guard/isolate_guard.dart';

class ChunkGenerator {
  static Future<void> generateChunk(int x, int z) async {
    await IsolateGuard.runIsolate(() async {
      // existing chunk generation logic here
    }, debugName: 'chunk-generator');
  }
}
