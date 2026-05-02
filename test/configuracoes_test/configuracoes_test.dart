import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/configuracoes.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Configuracoes', () {
    test('carregar configuracoes', () async {
      final configuracoesJson = await rootBundle.loadString('assets/configuracoes.json');
      final configuracoesMap = jsonDecode(configuracoesJson);
      expect(configuracoesMap, isNotNull);
      expect(configuracoesMap, isA<Map<String, dynamic>>());
    });

    test('validar estrutura de configuracoes', () async {
      final configuracoesJson = await rootBundle.loadString('assets/configuracoes.json');
      final configuracoesMap = jsonDecode(configuracoesJson);
      expect(configuracoesMap.keys, contains('som'));
      expect(configuracoesMap['som'], isA<Map<String, dynamic>>());
    });
  });
}
