import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rebcm/data/repository/name_repository.dart';
import 'package:rebcm/domain/usecase/validate_name_usecase.dart';

class MockNameRepository extends Mock implements NameRepository {}

void main() {
  late ValidateNameUsecase usecase;
  late MockNameRepository repository;

  setUp(() {
    repository = MockNameRepository();
    usecase = ValidateNameUsecase(repository);
  });

  test('should return false when name is duplicated', () async {
    when(() => repository.checkName('test_name')).thenAnswer((_) async => true);
    final result = await usecase('test_name');
    expect(result, false);
  });

  test('should return true when name is not duplicated', () async {
    when(() => repository.checkName('test_name')).thenAnswer((_) async => false);
    final result = await usecase('test_name');
    expect(result, true);
  });
}
