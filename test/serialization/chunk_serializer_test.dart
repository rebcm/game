import 'package:test/test.dart';
import 'package:rebcm/serialization/chunk_serializer.dart';
import 'package:rebcm/models/chunk.dart';

void main() {
  group('ChunkSerializer', () {
    test('serialize e deserialize', () {
      ChunkSerializer serializer = ChunkSerializer();
      Chunk originalChunk = Chunk(x: 1, y: 2, z: 3, blocks: Uint8List.fromList([1, 2, 3, 4]));

      Uint8List serializedData = serializer.serialize(originalChunk);
      Chunk deserializedChunk = serializer.deserialize(serializedData);

      expect(deserializedChunk.x, originalChunk.x);
      expect(deserializedChunk.y, originalChunk.y);
      expect(deserializedChunk.z, originalChunk.z);
      expect(deserializedChunk.blocks, originalChunk.blocks);
    });
  });
}
