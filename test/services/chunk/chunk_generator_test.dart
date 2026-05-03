import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/chunk/chunk_generator.dart';

void main() {
  test('generateChunk returns a Chunk', () async {
    final chunk = await ChunkGenerator.generateChunk(0, 0);
    expect(chunk, isNotNull);
  });
}
