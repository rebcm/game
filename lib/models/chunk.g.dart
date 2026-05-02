// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chunk _$ChunkFromJson(Map<String, dynamic> json) => Chunk(
      x: json['x'] as int,
      z: json['z'] as int,
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ChunkToJson(Chunk instance) => <String, dynamic>{
      'x': instance.x,
      'z': instance.z,
      'data': instance.data,
    };
