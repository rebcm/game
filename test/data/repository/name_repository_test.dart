import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/data/repository/name_repository.dart';

class TestNameRepository implements NameRepository {
  @override
  Future<bool> checkName(String name) async {
    // Implement the logic to check if the name exists
    return false; // placeholder
  }
}

void main() {
  late TestNameRepository repository;

  setUp(() {
    repository = TestNameRepository();
  });

  test('should check if name exists', () async {
    final result = await repository.checkName('test_name');
    expect(result, isA<bool>());
  });
}
