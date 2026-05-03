import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/serializacao/chunk_serializer.dart';
import 'package:rebcm/models/chunk.dart';

void main() {
  group('ChunkSerializer', () {
    test('serialize e deserialize', () {
      ChunkSerializer serializer = ChunkSerializer();
      Chunk chunk = Chunk(
        width: 10,
        height: 10,
        depth: 10,
        // ... outros dados do chunk
      );

      Uint8List bytes = serializer.serialize(chunk);
      Chunk deserializedChunk = serializer.deserialize(bytes);

      expect(deserializedChunk.width, chunk.width);
      expect(deserializedChunk.height, chunk.height);
      expect(deserializedChunk.depth, chunk.depth);
      // ... verificar outros dados do chunk
    });
  });
}
