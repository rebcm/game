// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenApiClient _$OpenApiClientFromJson(Map<String, dynamic> json) =>
    OpenApiClient(
      json['_dio'] == null
          ? null
          : Dio.fromJson(json['_dio'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenApiClientToJson(OpenApiClient instance) =>
    <String, dynamic>{
      '_dio': instance._dio.toJson(),
    };
