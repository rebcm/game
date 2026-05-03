import 'package:freezed/freezed.dart';

part 'world_schema.freezed.dart';
part 'world_schema.g.dart';

@freezed
class WorldSchema with _$WorldSchema {
  const factory WorldSchema({
    required String id,
    required String r2BucketReference,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorldSchema;

  factory WorldSchema.fromJson(Map<String, dynamic> json) => _$WorldSchemaFromJson(json);
}
