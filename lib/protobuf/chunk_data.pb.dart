// Generated code - Do not edit manually
// protoc --dart_out=. chunk_data.proto

///
//  Generated code. Do not modify.
//  source: chunk_data.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ChunkData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChunkData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'game.protobuf'), createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.P3)
    ..hasRequiredFields = false
  ;

  ChunkData._() : super();
  factory ChunkData({
    $core.Iterable<$core.int>? values,
  }) {
    final _result = create();
    if (values != null) {
      _result.values.addAll(values);
    }
    return _result;
  }
  factory ChunkData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChunkData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChunkData clone() => ChunkData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChunkData copyWith(void Function(ChunkData) updates) => super.copyWith((message) => updates(message as ChunkData)) as ChunkData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChunkData create() => ChunkData._();
  ChunkData createEmptyInstance() => create();
  static $pb.PbList<ChunkData> createRepeated() => $pb.PbList<ChunkData>();
  @$core.pragma('dart2js:noInline')
  static ChunkData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChunkData>(create);
  static ChunkData? _defaultInstance;
}

class ChunkData_A extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChunkData.A', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'game.protobuf'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'a', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ChunkData_A._() : super();
  factory ChunkData_A({
    $core.int? a,
  }) {
    final _result = create();
    if (a != null) {
      _result.a = a;
    }
    return _result;
  }
  factory ChunkData_A.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChunkData_A.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChunkData_A clone() => ChunkData_A()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChunkData_A copyWith(void Function(ChunkData_A) updates) => super.copyWith((message) => updates(message as ChunkData_A)) as ChunkData_A; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChunkData_A create() => ChunkData_A._();
  ChunkData_A createEmptyInstance() => create();
  static $pb.PbList<ChunkData_A> createRepeated() => $pb.PbList<ChunkData_A>();
  @$core.pragma('dart2js:noInline')
  static ChunkData_A getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChunkData_A>(create);
  static ChunkData_A? _defaultInstance;
}
