import 'package:flame/game.dart';
import 'package:rebcm/services/chunk_service.dart';

class RebecaGame extends FlameGame {
  late ChunkService _chunkService;

  @override
  Future<void> onLoad() async {
    _chunkService = ChunkService();
    // Use _chunkService to generate optimized chunks
  }
}
