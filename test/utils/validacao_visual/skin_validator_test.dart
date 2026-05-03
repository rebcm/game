import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/validacao_visual/skin_validator.dart';

void main() {
  group('SkinValidator', () {
    test('deve validar dimensoes da skin', () async {
      final validator = SkinValidator();
      expect(await validator.validateDimensions(), true);
    });

    test('deve validar paleta de cores', () async {
      final validator = SkinValidator();
      expect(await validator.validateColorPalette(), true);
    });

    test('deve verificar camada externa', () async {
      final validator = SkinValidator();
      expect(await validator.validateOuterLayer(), true);
    });
  });
}
