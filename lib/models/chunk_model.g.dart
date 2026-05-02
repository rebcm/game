// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunk_model.dart';

ChunkModel _$ChunkModelFromJson(Map<String, dynamic> json) => ChunkModel(
      x: json['x'] as int,
      z: json['z'] as int,
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ChunkModelToJson(ChunkModel instance) => <String, dynamic>{
      'x': instance.x,
      'z': instance.z,
      'data': instance.data,
    };
