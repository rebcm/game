import 'package:flutter_test/flutter_test.dart';
import 'package:game/errors/chunk_not_found_error.dart';

void main() {
  test('ChunkNotFoundError is created with message', () {
    final error = ChunkNotFoundError('Chunk not found');
    expect(error.message, 'Chunk not found');
  });

  test('ChunkNotFoundError is created from json', () {
    final json = {'message': 'Chunk not found'};
    final error = ChunkNotFoundError.fromJson(json);
    expect(error.message, 'Chunk not found');
  });
}
