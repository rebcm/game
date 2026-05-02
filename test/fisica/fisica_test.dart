import 'package:test/test.dart';
import 'package:rebcm/fisica/fisica.dart';

void main() {
  group('Fisica', () {
    late Fisica _fisica;

    setUp(() {
      _fisica = Fisica();
    });

    test('atualiza corretamente', () {
      _fisica.atualizar();
      // Verificações necessárias
    });
  });
}
