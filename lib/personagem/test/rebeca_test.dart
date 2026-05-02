import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/personagem/rebeca.dart';

void main() {
  group('Rebeca', () {
    test('inicia em Idle', () {
      final rebeca = Rebeca();
      expect(rebeca.estado, 'Idle');
    });

    test('muda para Walking ao mover', () {
      final rebeca = Rebeca();
      rebeca.mover();
      expect(rebeca.estado, 'Walking');
    });

    test('muda para Idle ao parar', () {
      final rebeca = Rebeca();
      rebeca.mover();
      rebeca.parar();
      expect(rebeca.estado, 'Idle');
    });

    test('notifica listeners ao mudar estado', () {
      final rebeca = Rebeca();
      var notificado = false;
      rebeca.addListener(() => notificado = true);
      rebeca.mover();
      expect(notificado, true);
    });
  });
}
