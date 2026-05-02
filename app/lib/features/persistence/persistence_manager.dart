import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'chunk_versioning_strategy.dart';

class PersistenceManager {
  Future<String> getWorldDirectoryPath(String worldName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/worlds/$worldName';
  }

  Future<void> saveChunk(String worldName, int chunkX, int chunkZ, List<int> chunkData, int version) async {
    final chunkFilePath = ChunkVersioningStrategy.getChunkFilePath(worldName, chunkX, chunkZ, version);
    final directory = Directory(ChunkVersioningStrategy.getChunkDirectoryPath(worldName));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final file = File(chunkFilePath);
    await file.writeAsBytes(chunkData);
  }

  Future<List<int>> loadChunk(String worldName, int chunkX, int chunkZ) async {
    final latestVersion = ChunkVersioningStrategy.getLatestChunkVersion(worldName, chunkX, chunkZ);
    final chunkFilePath = ChunkVersioningStrategy.getChunkFilePath(worldName, chunkX, chunkZ, latestVersion);
    final file = File(chunkFilePath);
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      return []; // or throw an exception if chunk not found
    }
  }
}
