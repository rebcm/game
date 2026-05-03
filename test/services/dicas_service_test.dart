import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/dicas_service.dart';

void main() {
  group('DicasService', () {
    test('deve validar aprovação técnica', () async {
      final service = DicasService();
      await service.validarAprovacaoTecnica();
    });

    test('deve carregar dicas', () async {
      final service = DicasService();
      await service.carregarDicas();
    });
  });
}
