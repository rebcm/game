import 'dart:typed_data';
import 'package:rebcm/models/chunk_data.dart';

class SerializationUtils {
  static Uint8List serializeChunkToBinary(ChunkData chunk) {
    // Implement binary serialization logic here
    // For demonstration, let's assume we're just converting the block data to bytes
    return Uint8List.fromList(chunk.blocks);
  }

  static ChunkData deserializeChunkFromBinary(Uint8List binaryData) {
    // Implement binary deserialization logic here
    // For demonstration, let's assume we're just converting the bytes back to block data
    return ChunkData(
      x: 0,
      y: 0,
      z: 0,
      blocks: binaryData.map((e) => e).toList(),
    );
  }
}
