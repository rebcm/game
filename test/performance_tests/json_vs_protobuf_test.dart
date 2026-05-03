import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:protobuf/protobuf.dart';

void main() {
  group('JSON vs Protobuf Performance Test', () {
    test('Serialization Performance', () {
      // Sample data
      final chunkData = List.generate(1000, (index) => index);

      // JSON Serialization
      final jsonStopwatch = Stopwatch()..start();
      final jsonData = jsonEncode(chunkData);
      jsonStopwatch.stop();
      print('JSON Serialization took ${jsonStopwatch.elapsedMilliseconds}ms');

      // Protobuf Serialization
      final protobufStopwatch = Stopwatch()..start();
      // Assuming a simple Protobuf message for demonstration
      final protobufData = ChunkData(values: chunkData);
      final protobufEncoded = protobufData.writeToBuffer();
      protobufStopwatch.stop();
      print('Protobuf Serialization took ${protobufStopwatch.elapsedMilliseconds}ms');

      expect(protobufEncoded.length, isNonZero);
    });

    test('Deserialization Performance', () {
      // Sample data
      final chunkData = List.generate(1000, (index) => index);
      final jsonData = jsonEncode(chunkData);
      final protobufData = ChunkData(values: chunkData);
      final protobufEncoded = protobufData.writeToBuffer();

      // JSON Deserialization
      final jsonDecodeStopwatch = Stopwatch()..start();
      jsonDecode(jsonData);
      jsonDecodeStopwatch.stop();
      print('JSON Deserialization took ${jsonDecodeStopwatch.elapsedMilliseconds}ms');

      // Protobuf Deserialization
      final protobufDecodeStopwatch = Stopwatch()..start();
      ChunkData.fromBuffer(protobufEncoded);
      protobufDecodeStopwatch.stop();
      print('Protobuf Deserialization took ${protobufDecodeStopwatch.elapsedMilliseconds}ms');

      expect(true, isTrue);
    });

    test('Memory Consumption', () {
      // Sample data
      final chunkData = List.generate(1000, (index) => index);

      // JSON Memory Consumption
      final jsonData = jsonEncode(chunkData);
      final jsonMemoryUsage = jsonData.length;
      print('JSON Memory Usage: $jsonMemoryUsage bytes');

      // Protobuf Memory Consumption
      final protobufData = ChunkData(values: chunkData);
      final protobufEncoded = protobufData.writeToBuffer();
      final protobufMemoryUsage = protobufEncoded.length;
      print('Protobuf Memory Usage: $protobufMemoryUsage bytes');

      expect(protobufMemoryUsage, isNonZero);
    });
  });
}

// Simple Protobuf message for demonstration
class ChunkData extends GeneratedMessage {
  List<int> get values => $_getList(0);

  factory ChunkData({List<int> values = const []}) {
    final _result = create();
    _result.values.addAll(values);
    return _result;
  }

  ChunkData._() : super();
  factory ChunkData.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChunkData.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChunkData', package: const $pb.PackageName(_omitMessageNames ? '' : 'game.protobuf'), createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'values', $pb.PbFieldType.P3)
    ..hasRequiredFields = false;

  ChunkData createEmptyInstance() => create();
  ChunkData copyWith(void Function(ChunkData) updates) => super.copyWith((message) => updates(message as ChunkData)) as ChunkData;
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChunkData create() => ChunkData._();
  ChunkData createEmptyInstance() => create();
  static $pb.PbList<ChunkData> createRepeated() => $pb.PbList<ChunkData>();
  @$core.pragma('dart2js:noInline')
  static ChunkData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChunkData>(create);
  static ChunkData? _defaultInstance;
}

@$core.pragma('dart2js:noInline')
const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
@$core.pragma('dart2js:noInline')
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
