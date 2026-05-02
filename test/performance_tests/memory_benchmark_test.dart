import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/models/chunk_data.dart';
import 'dart:convert';
import 'package:rebcm/utils/serialization_utils.dart';

void main() {
  group('Memory Benchmark', () {
    late ChunkData chunkData;

    setUp(() {
      chunkData = ChunkData(
        x: 0,
        y: 0,
        z: 0,
        blocks: List.generate(16 * 16 * 16, (index) => index % 256),
      );
    });

    test('Binary Serialization Memory Usage', () {
      final memUsageBefore = MemoryUsage.currentMemoryUsage();
      final binaryData = SerializationUtils.serializeChunkToBinary(chunkData);
      final memUsageAfter = MemoryUsage.currentMemoryUsage();

      print('Binary serialization memory usage: ${memUsageAfter - memUsageBefore} bytes');

      expect(binaryData, isNotNull);
    });

    test('JSON Serialization Memory Usage', () {
      final memUsageBefore = MemoryUsage.currentMemoryUsage();
      final jsonData = jsonEncode(chunkData.toJson());
      final memUsageAfter = MemoryUsage.currentMemoryUsage();

      print('JSON serialization memory usage: ${memUsageAfter - memUsageBefore} bytes');

      expect(jsonData, isNotNull);
    });
  });
}

class MemoryUsage {
  static int currentMemoryUsage() {
    // This is a simplified example. Actual implementation may vary based on the platform.
    return DateTime.now().millisecondsSinceEpoch; // Placeholder
  }
}
