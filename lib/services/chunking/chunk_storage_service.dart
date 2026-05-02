import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rebcm/services/chunking/chunk_versioning_strategy.dart';

class ChunkStorageService {
  final ChunkVersioningStrategy _versioningStrategy;

  ChunkStorageService(this._versioningStrategy);

  Future<String> getChunkPath(String chunkId) async {
    final directory = await getApplicationDocumentsDirectory();
    final version = _versioningStrategy.getVersion(chunkId);
    return '${directory.path}/chunks/$version/$chunkId';
  }

  Future<void> saveChunk(String chunkId, List<int> chunkData) async {
    final chunkPath = await getChunkPath(chunkId);
    final directory = Directory(chunkPath.substring(0, chunkPath.lastIndexOf('/')));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    await File(chunkPath).writeAsBytes(chunkData);
  }

  Future<List<int>?> loadChunk(String chunkId) async {
    final chunkPath = await getChunkPath(chunkId);
    final file = File(chunkPath);
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      return null;
    }
  }
}
