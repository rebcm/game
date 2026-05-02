import 'package:rebcm/models/chunk.dart';
import 'package:rebcm/services/isolates/mesh_generator_isolate.dart';

class ChunkService {
  Future<void> generateMesh(Chunk chunk) async {
    final SendPort sendPort = await MeshGeneratorIsolate._initIsolate();
    sendPort.send(chunk);
  }
}
