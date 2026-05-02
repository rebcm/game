import 'package:rebcm/models/chunk.dart';
import 'package:rebcm/services/isolates/mesh_generator_isolate.dart';

class ChunkService {
  Future<dynamic> generateMesh(Chunk chunk) async {
    return await MeshGeneratorIsolate.generateMesh(chunk);
  }
}
