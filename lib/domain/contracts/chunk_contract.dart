/// Contract for chunk data structure.
///
/// This defines the exact structure of the payload for chunk data,
/// including metadata for flow control.
library chunk_contract;

/// Chunk data structure.
///
/// Contains the necessary information for a chunk in the game world.
class Chunk {
  /// Chunk's X coordinate.
  final int x;

  /// Chunk's Z coordinate.
  final int z;

  /// 3D array representing the blocks within the chunk.
  final List<List<List<int>>> blocks;

  /// Metadata indicating if this is the last chunk in a sequence.
  final bool isLastChunk;

  /// Constructor for creating a Chunk instance.
  Chunk({
    required this.x,
    required this.z,
    required this.blocks,
    required this.isLastChunk,
  });

  /// Factory method to create a Chunk from a JSON object.
  factory Chunk.fromJson(Map<String, dynamic> json) {
    return Chunk(
      x: json['x'],
      z: json['z'],
      blocks: _parseBlocks(json['blocks']),
      isLastChunk: json['isLastChunk'],
    );
  }

  /// Converts the Chunk instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'z': z,
      'blocks': blocks,
      'isLastChunk': isLastChunk,
    };
  }

  static List<List<List<int>>> _parseBlocks(List<dynamic> blocksJson) {
    return blocksJson.map((layer) => List<List<int>>.from(layer.map((row) => List<int>.from(row)))).toList();
  }
}
