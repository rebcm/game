import 'package:test/test.dart';
import 'package:game/errors/chunk_not_found_error.dart';

void main() {
  test('ChunkNotFoundError is created with correct message', () {
    final error = ChunkNotFoundError('Test message');
    expect(error.message, 'Test message');
  });

  test('ChunkNotFoundError is created from code', () {
    final error = ChunkNotFoundError.fromCode(404);
    expect(error.message, 'Chunk not found with code 404');
  });
}
