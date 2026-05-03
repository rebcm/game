import 'package:flutter_test/flutter_test.dart';
import 'package:game/serialization/json_chunk_serializer.dart';
import 'package:game/serialization/protobuf_chunk_serializer.dart';
import 'dart:typed_data';

void main() {
  test('JSON vs Protobuf serialization performance', () async {
    final jsonSerializer = JsonChunkSerializer();
    final protobufSerializer = ProtobufChunkSerializer();

    final chunkData = Uint8List.fromList(List.generate(16 * 16 * 16, (index) => index % 256));

    final jsonStopwatch = Stopwatch()..start();
    final jsonSerialized = jsonSerializer.serialize(chunkData);
    jsonStopwatch.stop();

    final protobufStopwatch = Stopwatch()..start();
    final protobufSerialized = protobufSerializer.serialize(chunkData);
    protobufStopwatch.stop();

    print('JSON serialization took ${jsonStopwatch.elapsedMilliseconds}ms');
    print('Protobuf serialization took ${protobufStopwatch.elapsedMilliseconds}ms');
    print('JSON size: ${jsonSerialized.length} bytes');
    print('Protobuf size: ${protobufSerialized.length} bytes');

    expect(jsonSerialized.length, greaterThan(0));
    expect(protobufSerialized.length, greaterThan(0));
  });

  test('JSON vs Protobuf deserialization performance', () async {
    final jsonSerializer = JsonChunkSerializer();
    final protobufSerializer = ProtobufChunkSerializer();

    final chunkData = Uint8List.fromList(List.generate(16 * 16 * 16, (index) => index % 256));

    final jsonSerialized = jsonSerializer.serialize(chunkData);
    final protobufSerialized = protobufSerializer.serialize(chunkData);

    final jsonStopwatch = Stopwatch()..start();
    jsonSerializer.deserialize(jsonSerialized);
    jsonStopwatch.stop();

    final protobufStopwatch = Stopwatch()..start();
    protobufSerializer.deserialize(protobufSerialized);
    protobufStopwatch.stop();

    print('JSON deserialization took ${jsonStopwatch.elapsedMilliseconds}ms');
    print('Protobuf deserialization took ${protobufStopwatch.elapsedMilliseconds}ms');

    expect(jsonStopwatch.elapsedMilliseconds, greaterThan(0));
    expect(protobufStopwatch.elapsedMilliseconds, greaterThan(0));
  });
}
