import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:protobuf/protobuf.dart';
import '../lib/models/chunk.pb.dart';

void main() {
  group('Chunk Serialization Performance Test', () {
    test('JSON vs Protobuf serialization', () {
      // Create a sample chunk
      Chunk chunk = Chunk();
      chunk.width = 16;
      chunk.height = 16;
      chunk.depth = 16;
      // ... populate chunk data

      // JSON serialization
      Stopwatch jsonStopwatch = Stopwatch()..start();
      String jsonString = jsonEncode(chunk.toJson());
      jsonStopwatch.stop();
      print('JSON serialization took ${jsonStopwatch.elapsedMilliseconds}ms');

      // Protobuf serialization
      Stopwatch protobufStopwatch = Stopwatch()..start();
      List<int> protobufBytes = chunk.writeToBuffer();
      protobufStopwatch.stop();
      print('Protobuf serialization took ${protobufStopwatch.elapsedMilliseconds}ms');

      // Compare sizes
      print('JSON size: ${jsonString.length} bytes');
      print('Protobuf size: ${protobufBytes.length} bytes');
    });

    test('JSON vs Protobuf deserialization', () {
      // Create a sample chunk
      Chunk chunk = Chunk();
      chunk.width = 16;
      chunk.height = 16;
      chunk.depth = 16;
      // ... populate chunk data

      // JSON serialization
      String jsonString = jsonEncode(chunk.toJson());

      // Protobuf serialization
      List<int> protobufBytes = chunk.writeToBuffer();

      // JSON deserialization
      Stopwatch jsonStopwatch = Stopwatch()..start();
      jsonDecode(jsonString);
      jsonStopwatch.stop();
      print('JSON deserialization took ${jsonStopwatch.elapsedMilliseconds}ms');

      // Protobuf deserialization
      Stopwatch protobufStopwatch = Stopwatch()..start();
      Chunk.fromBuffer(protobufBytes);
      protobufStopwatch.stop();
      print('Protobuf deserialization took ${protobufStopwatch.elapsedMilliseconds}ms');
    });
  });
}
