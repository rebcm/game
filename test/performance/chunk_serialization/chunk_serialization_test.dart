import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/chunk.dart';
import 'dart:convert';
import 'package:protobuf/protobuf.dart' as $pb;

void main() {
  group('Chunk Serialization Performance Test', () {
    late Chunk chunk;

    setUp(() {
      chunk = Chunk(
        // Initialize chunk with test data
        width: 16,
        height: 16,
        depth: 16,
        blocks: List.generate(16 * 16 * 16, (index) => index % 256),
      );
    });

    test('JSON serialization performance', () {
      final stopwatch = Stopwatch()..start();
      final jsonString = jsonEncode(chunk.toJson());
      final jsonTime = stopwatch.elapsedMicroseconds;

      expect(jsonString, isNotEmpty);
      print('JSON serialization time: $jsonTime microseconds');
    });

    test('Protobuf serialization performance', () {
      final stopwatch = Stopwatch()..start();
      final protobufChunk = ChunkProtobuf(
        width: chunk.width,
        height: chunk.height,
        depth: chunk.depth,
        blocks: chunk.blocks,
      );
      final protobufBytes = protobufChunk.writeToBuffer();
      final protobufTime = stopwatch.elapsedMicroseconds;

      expect(protobufBytes, isNotEmpty);
      print('Protobuf serialization time: $protobufTime microseconds');
    });

    test('JSON vs Protobuf serialization performance comparison', () {
      final jsonStopwatch = Stopwatch()..start();
      final jsonString = jsonEncode(chunk.toJson());
      final jsonTime = jsonStopwatch.elapsedMicroseconds;

      final protobufStopwatch = Stopwatch()..start();
      final protobufChunk = ChunkProtobuf(
        width: chunk.width,
        height: chunk.height,
        depth: chunk.depth,
        blocks: chunk.blocks,
      );
      final protobufBytes = protobufChunk.writeToBuffer();
      final protobufTime = protobufStopwatch.elapsedMicroseconds;

      print('JSON serialization time: $jsonTime microseconds');
      print('Protobuf serialization time: $protobufTime microseconds');
      expect(protobufTime <= jsonTime, isTrue, reason: 'Protobuf should be faster or equal to JSON');
    });
  });
}

class Chunk {
  final int width;
  final int height;
  final int depth;
  final List<int> blocks;

  Chunk({required this.width, required this.height, required this.depth, required this.blocks});

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
      'blocks': blocks,
    };
  }
}

class ChunkProtobuf extends $pb.GeneratedMessage {
  factory ChunkProtobuf({
    int? width,
    int? height,
    int? depth,
    List<int>? blocks,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (depth != null) {
      _result.depth = depth;
    }
    if (blocks != null) {
      _result.blocks.addAll(blocks);
    }
    return _result;
  }

  ChunkProtobuf._() : super();
  factory ChunkProtobuf.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChunkProtobuf.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChunkProtobuf', package: const $pb.PackageRef(_omitPackageNames ? '' : 'game.models'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'width', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'height', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'depth', $pb.PbFieldType.O3)
    ..p<$core.int>(4, _omitFieldNames ? '' : 'blocks', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ChunkProtobuf clone() => ChunkProtobuf()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ChunkProtobuf copyWith(void Function(ChunkProtobuf) updates) => super.copyWith((message) => updates(message as ChunkProtobuf)) as ChunkProtobuf;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChunkProtobuf create() => ChunkProtobuf._();
  ChunkProtobuf createEmptyInstance() => create();
  static $pb.PbList<ChunkProtobuf> createRepeated() => $pb.PbList<ChunkProtobuf>();
  @$core.pragma('dart2js:noInline')
  static ChunkProtobuf getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChunkProtobuf>(create);
  static ChunkProtobuf? _defaultInstance;
}

T? _omitEnumNames<T>(T? value) => value;

String? _omitMessageNames(bool isForPb) => isForPb ? '' : 'game.models';

String? _omitFieldNames(bool isForPb) => isForPb ? '' : 'game.models';

String? _omitPackageNames(bool isForPb) => isForPb ? '' : 'game.models';
