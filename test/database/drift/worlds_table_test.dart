import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/database/drift/schema/worlds_schema.dart';
import 'package:drift/native.dart';

void main() {
  late WorldsDatabase db;

  setUp(() {
    db = WorldsDatabase(NativeDatabase.memory());
  });

  test('should create a world', () async {
    final world = await db.into(db.worlds).insertReturning(WorldsCompanion.insert(name: 'Test World', bucketReference: 'test-bucket'));
    expect(world.name, 'Test World');
    expect(world.bucketReference, 'test-bucket');
  });
}
