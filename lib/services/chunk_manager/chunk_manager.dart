import 'package:game/services/chunk_manager/buffer_zone.dart';
import 'package:game/services/chunk_manager/chunk.dart';

class ChunkManager with ChangeNotifier {
  List<Chunk> _allChunks = [];
  Chunk _playerChunk = Chunk(x: 0, z: 0);
  BufferZone _bufferZone = BufferZone(radius: 2);

  List<Chunk> get chunksToPreload => _bufferZone.getChunksToPreload(_allChunks, _playerChunk);

  void updatePlayerChunk(Chunk newChunk) {
    _playerChunk = newChunk;
    notifyListeners();
  }

  void updateAllChunks(List<Chunk> newChunks) {
    _allChunks = newChunks;
    notifyListeners();
  }
}
