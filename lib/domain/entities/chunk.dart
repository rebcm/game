import 'package:game/domain/contracts/chunk_contract.dart';

/// Represents a chunk in the game world.
///
/// This class encapsulates the data and behavior associated with a chunk.
class ChunkEntity {
  final Chunk _chunk;

  ChunkEntity(this._chunk);

  /// Gets the underlying chunk data.
  Chunk get chunk => _chunk;
}
