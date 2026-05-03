import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/dicas_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('deve retornar true quando as dicas são aprovadas', () async {
    final dicasService = DicasService();
    final httpClient = MockClient((request) async {
      return http.Response('approved_by_game_designer=true', 200);
    });
    dicasService.verificarAprovacao().then((value) {
      expect(value, true);
    });
  });

  test('deve retornar false quando as dicas não são aprovadas', () async {
    final dicasService = DicasService();
    final httpClient = MockClient((request) async {
      return http.Response('approved_by_game_designer=false', 200);
    });
    dicasService.verificarAprovacao().then((value) {
      expect(value, false);
    });
  });
}
