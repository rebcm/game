import 'package:flutter_test/flutter_test.dart';
import 'package:game/database/d1_adapter/d1_world_schema.dart';
import 'package:game/database/world_schema.dart';

void main() {
  group('D1WorldSchema', () {
    test('fromD1Row converts row to WorldSchema', () {
      final row = {
        'id': 'test-id',
        'r2BucketReference': 'test-bucket',
        'createdAt': 1710000000000,
        'updatedAt': 1710000000000,
      };

      final world = D1WorldSchema.fromD1Row(row);

      expect(world.id, 'test-id');
      expect(world.r2BucketReference, 'test-bucket');
      expect(world.createdAt, DateTime.fromMillisecondsSinceEpoch(1710000000000));
      expect(world.updatedAt, DateTime.fromMillisecondsSinceEpoch(1710000000000));
    });

    test('toD1Params converts WorldSchema to params', () {
      final world = WorldSchema(
        id: 'test-id',
        r2BucketReference: 'test-bucket',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1710000000000),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(1710000000000),
      );

      final params = D1WorldSchema.toD1Params(world);

      expect(params['id'], 'test-id');
      expect(params['r2BucketReference'], 'test-bucket');
      expect(params['createdAt'], 1710000000000);
      expect(params['updatedAt'], 1710000000000);
    });
  });
}
