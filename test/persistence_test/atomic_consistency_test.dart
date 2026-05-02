import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/data/repository.dart';
import 'package:rebcm/data/datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockDataSource extends Mock implements DataSource {}

void main() {
  late Repository repository;
  late MockDataSource dataSource;

  setUp(() {
    dataSource = MockDataSource();
    repository = Repository(dataSource);
  });

  test('should rollback transaction when insertion fails', () async {
    when(() => dataSource.insert(any())).thenThrow(Exception('Insertion failed'));
    when(() => dataSource.rollback()).thenAnswer((_) async {});

    expect(() async => await repository.insert('test'), throwsA(isA<Exception>()));
    verify(() => dataSource.rollback()).called(1);
  });

  test('should not rollback transaction when insertion succeeds', () async {
    when(() => dataSource.insert(any())).thenAnswer((_) async {});
    when(() => dataSource.rollback()).thenAnswer((_) async {});

    await repository.insert('test');
    verifyNever(() => dataSource.rollback());
  });
}
