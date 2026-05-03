import 'package:test/test.dart';
import 'package:game/services/dicas_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('DicasService', () {
    test('verificarAprovacaoTecnica retorna true quando as dicas são aprovadas', () async {
      final dicasService = DicasService();
      dicasService.httpClient = MockClient((request) async {
        return http.Response('approved', 200);
      });
      final result = await dicasService.verificarAprovacaoTecnica();
      expect(result, true);
    });

    test('verificarAprovacaoTecnica retorna false quando as dicas não são aprovadas', () async {
      final dicasService = DicasService();
      dicasService.httpClient = MockClient((request) async {
        return http.Response('not approved', 404);
      });
      final result = await dicasService.verificarAprovacaoTecnica();
      expect(result, false);
    });
  });
}
