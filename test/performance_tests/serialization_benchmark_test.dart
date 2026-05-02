import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/chunk_data.dart';
import 'dart:convert';
import 'package:rebcm/utils/serialization_utils.dart';

void main() {
  group('Serialization Benchmark', () {
    late ChunkData chunkData;

    setUp(() {
      chunkData = ChunkData(
        x: 0,
        y: 0,
        z: 0,
        blocks: List.generate(16 * 16 * 16, (index) => index % 256),
      );
    });

    test('Binary Serialization', () {
      Stopwatch stopwatch = Stopwatch()..start();
      final binaryData = SerializationUtils.serializeChunkToBinary(chunkData);
      stopwatch.stop();
      print('Binary serialization took ${stopwatch.elapsedMilliseconds}ms');

      expect(binaryData, isNotNull);
    });

    test('JSON Serialization', () {
      Stopwatch stopwatch = Stopwatch()..start();
      final jsonData = jsonEncode(chunkData.toJson());
      stopwatch.stop();
      print('JSON serialization took ${stopwatch.elapsedMilliseconds}ms');

      expect(jsonData, isNotNull);
    });

    test('Binary Deserialization', () {
      final binaryData = SerializationUtils.serializeChunkToBinary(chunkData);

      Stopwatch stopwatch = Stopwatch()..start();
      SerializationUtils.deserializeChunkFromBinary(binaryData);
      stopwatch.stop();
      print('Binary deserialization took ${stopwatch.elapsedMilliseconds}ms');
    });

    test('JSON Deserialization', () {
      final jsonData = jsonEncode(chunkData.toJson());

      Stopwatch stopwatch = Stopwatch()..start();
      ChunkData.fromJson(jsonDecode(jsonData));
      stopwatch.stop();
      print('JSON deserialization took ${stopwatch.elapsedMilliseconds}ms');
    });
  });
}
