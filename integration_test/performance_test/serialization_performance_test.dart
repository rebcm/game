import 'package:flutter_test/flutter_test.dart';
import 'package:game/chunk.dart';
import 'dart:convert';
import 'package:protobuf/protobuf.dart' as $pb;
import 'chunk.pb.dart';

void main() {
  group('Serialization Performance Test', () {
    test('JSON vs Protobuf', () {
      Chunk chunk = Chunk();
      chunk.init();

      Stopwatch stopwatch = Stopwatch()..start();
      String jsonString = jsonEncode(chunk.toJson());
      int jsonTime = stopwatch.elapsedMilliseconds;

      stopwatch.reset();
      List<int> protobufBytes = chunk.writeToBuffer();
      int protobufTime = stopwatch.elapsedMilliseconds;

      expect(jsonTime, greaterThan(protobufTime));
    });

    test('Deserialization Performance', () {
      Chunk chunk = Chunk();
      chunk.init();

      String jsonString = jsonEncode(chunk.toJson());
      List<int> protobufBytes = chunk.writeToBuffer();

      Stopwatch stopwatch = Stopwatch()..start();
      jsonDecode(jsonString);
      int jsonTime = stopwatch.elapsedMilliseconds;

      stopwatch.reset();
      Chunk.fromBuffer(protobufBytes);
      int protobufTime = stopwatch.elapsedMilliseconds;

      expect(jsonTime, greaterThan(protobufTime));
    });
  });
}
