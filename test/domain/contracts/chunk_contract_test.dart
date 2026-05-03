import 'package:flutter_test/flutter_test.dart';
import 'package:game/domain/contracts/chunk_contract.dart';

void main() {
  group('Chunk Contract Tests', () {
    test('should create a Chunk instance correctly', () {
      final chunk = Chunk(
        x: 0,
        z: 0,
        blocks: [
          [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 1],
          ],
        ],
        isLastChunk: false,
      );

      expect(chunk.x, 0);
      expect(chunk.z, 0);
      expect(chunk.blocks, [
        [
          [1, 1, 1],
          [1, 0, 1],
          [1, 1, 1],
        ],
      ]);
      expect(chunk.isLastChunk, false);
    });

    test('should convert Chunk to JSON correctly', () {
      final chunk = Chunk(
        x: 0,
        z: 0,
        blocks: [
          [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 1],
          ],
        ],
        isLastChunk: false,
      );

      final json = chunk.toJson();

      expect(json, {
        'x': 0,
        'z': 0,
        'blocks': [
          [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 1],
          ],
        ],
        'isLastChunk': false,
      });
    });

    test('should create Chunk from JSON correctly', () {
      final json = {
        'x': 0,
        'z': 0,
        'blocks': [
          [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 1],
          ],
        ],
        'isLastChunk': false,
      };

      final chunk = Chunk.fromJson(json);

      expect(chunk.x, 0);
      expect(chunk.z, 0);
      expect(chunk.blocks, [
        [
          [1, 1, 1],
          [1, 0, 1],
          [1, 1, 1],
        ],
      ]);
      expect(chunk.isLastChunk, false);
    });
  });
}
