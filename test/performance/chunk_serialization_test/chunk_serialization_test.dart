import 'package:flutter_test/flutter_test.dart';
import 'package:protobuf/protobuf.dart';
import 'dart:convert';
import 'package:your_game/chunk.dart'; // Adjust the import according to your actual chunk.dart location

void main() {
  group('Chunk Serialization Performance Test', () {
    late Chunk chunk;

    setUp(() {
      chunk = Chunk(); // Initialize your chunk with some data
      // chunk.init(); // Uncomment and adjust according to your Chunk class initialization
    });

    test('JSON serialization performance', () {
      final stopwatch = Stopwatch()..start();
      final jsonData = jsonEncode(chunk.toJson());
      stopwatch.stop();
      print('JSON serialization took ${stopwatch.elapsedMilliseconds}ms');
      expect(jsonData, isNotEmpty);
    });

    test('Protobuf serialization performance', () {
      final protobufChunk = ChunkProtobuf()..fromChunk(chunk); // Assuming you have a protobuf representation
      final stopwatch = Stopwatch()..start();
      final protobufData = protobufChunk.writeToBuffer();
      stopwatch.stop();
      print('Protobuf serialization took ${stopwatch.elapsedMilliseconds}ms');
      expect(protobufData, isNotEmpty);
    });

    test('JSON deserialization performance', () {
      final jsonData = jsonEncode(chunk.toJson());
      final stopwatch = Stopwatch()..start();
      jsonDecode(jsonData);
      stopwatch.stop();
      print('JSON deserialization took ${stopwatch.elapsedMilliseconds}ms');
      expect(jsonData, isNotEmpty);
    });

    test('Protobuf deserialization performance', () {
      final protobufChunk = ChunkProtobuf()..fromChunk(chunk);
      final protobufData = protobufChunk.writeToBuffer();
      final stopwatch = Stopwatch()..start();
      ChunkProtobuf.fromBuffer(protobufData);
      stopwatch.stop();
      print('Protobuf deserialization took ${stopwatch.elapsedMilliseconds}ms');
      expect(protobufData, isNotEmpty);
    });
  });
}
