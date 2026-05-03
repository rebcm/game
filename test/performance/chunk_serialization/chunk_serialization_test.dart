import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/chunk_manager/chunk.dart';
import 'dart:convert';
import 'package:protobuf/protobuf.dart' as $pb;

void main() {
  group('Chunk Serialization Performance Test', () {
    late Chunk chunk;

    setUp(() {
      chunk = Chunk(
        x: 0,
        y: 0,
        z: 0,
        blocks: List.generate(16 * 16 * 16, (index) => index % 256),
      );
    });

    test('JSON serialization performance', () {
      final stopwatch = Stopwatch()..start();
      final jsonData = jsonEncode(chunk.toJson());
      final jsonTime = stopwatch.elapsedMicroseconds;

      final stopwatchDecode = Stopwatch()..start();
      jsonDecode(jsonData);
      final jsonDecodeTime = stopwatchDecode.elapsedMicroseconds;

      print('JSON serialization time: $jsonTime microseconds');
      print('JSON deserialization time: $jsonDecodeTime microseconds');
    });

    test('Protobuf serialization performance', () {
      final chunkProto = chunk.toProto();
      final stopwatch = Stopwatch()..start();
      final protoData = chunkProto.writeToBuffer();
      final protoTime = stopwatch.elapsedMicroseconds;

      final stopwatchDecode = Stopwatch()..start();
      Chunk.fromProto(ChunkProto.fromBuffer(protoData));
      final protoDecodeTime = stopwatchDecode.elapsedMicroseconds;

      print('Protobuf serialization time: $protoTime microseconds');
      print('Protobuf deserialization time: $protoDecodeTime microseconds');
    });
  });
}

