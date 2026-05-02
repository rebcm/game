import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk_generation/chunk_generator.dart';

void main() {
  test('Chunk generation test', () async {
    final chunk = await ChunkGenerator.generateChunk(0, 0);
    expect(chunk.x, 0);
    expect(chunk.z, 0);
  });
}
