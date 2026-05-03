import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/telemetria/telemetria_dicas.dart';

void main() {
  group('TelemetriaDicas', () {
    late TelemetriaDicas telemetriaDicas;

    setUp(() {
      telemetriaDicas = TelemetriaDicas();
    });

    test('inicia com valores zerados', () {
      expect(telemetriaDicas.dicasExibidas, 0);
      expect(telemetriaDicas.dicasIgnoradas, 0);
    });

    test('registra dica exibida', () {
      telemetriaDicas.dicaExibida();
      expect(telemetriaDicas.dicasExibidas, 1);
    });

    test('registra dica ignorada', () {
      telemetriaDicas.dicaIgnorada();
      expect(telemetriaDicas.dicasIgnoradas, 1);
    });

    test('converte para JSON corretamente', () {
      telemetriaDicas.dicaExibida();
      telemetriaDicas.dicaIgnorada();
      final json = telemetriaDicas.toJson();
      expect(json['dicasExibidas'], 1);
      expect(json['dicasIgnoradas'], 1);
    });
  });
}
