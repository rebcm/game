import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/validacao_visual/skin_validator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SkinValidator', () {
    test('should validate skin dimensions', () async {
      final validator = SkinValidator();
      final isValid = await validator.validateSkinDimensions();
      expect(isValid, true);
    });
  });
}
