import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/name_service.dart';

void main() {
  group('Name Service Duplicate Name Validation', () {
    late NameService nameService;

    setUp(() {
      nameService = NameService();
    });

    test('should not accept duplicate names', () async {
      await nameService.addName('Rebeca');
      final result = await nameService.addName('Rebeca');
      expect(result, false);
    });

    test('should accept different names', () async {
      await nameService.addName('Rebeca');
      final result = await nameService.addName('Rebeca Alves');
      expect(result, true);
    });

    test('should return true for an empty list of names', () async {
      final result = await nameService.addName('New Name');
      expect(result, true);
    });
  });
}
