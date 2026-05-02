import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/data/repository.dart';
import 'package:rebcm/data/database.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabase extends Mock implements Database {}

class MockRepository extends Mock implements Repository {}

void main() {
  late Database database;
  late Repository repository;

  setUp(() {
    database = MockDatabase();
    repository = MockRepository();
  });

  test('should rollback transaction when R2 fails', () async {
    when(() => database.insert(any())).thenAnswer((_) async => 1);
    when(() => database.update(any())).thenThrow(Exception('R2 failed'));

    expect(() async => await repository.saveData('data'), throwsException);

    verify(() => database.rollback()).called(1);
  });

  test('should not have orphaned records after rollback', () async {
    when(() => database.insert(any())).thenAnswer((_) async => 1);
    when(() => database.update(any())).thenThrow(Exception('R2 failed'));

    try {
      await repository.saveData('data');
    } catch (_) {}

    verifyNever(() => database.commit());
    verify(() => database.rollback()).called(1);
  });
}
