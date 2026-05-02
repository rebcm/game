import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:rebcm/servicos/http/cliente_http.dart';
import 'package:rebcm/servicos/http/excecao_http.dart';

void main() {
  group('ClienteHttp', () {
    test('sucesso', () async {
      final client = ClienteHttp(MockClient((request) async {
        return http.Response('{"data": "ok"}', 200);
      }));
      final response = await client.get(Uri.parse('https://example.com/api'));
      expect(response, {'data': 'ok'});
    });

    test('erro 400', () async {
      final client = ClienteHttp(MockClient((request) async {
        return http.Response('{"codigo": 400, "mensagem": "Erro de validação"}', 400);
      }));
      expect(() async => await client.get(Uri.parse('https://example.com/api')), throwsA(isA<ExcecaoHttp>()));
    });

    test('erro inesperado', () async {
      final client = ClienteHttp(MockClient((request) async {
        return http.Response('Erro interno', 500);
      }));
      expect(() async => await client.get(Uri.parse('https://example.com/api')), throwsA(isA<ExcecaoHttp>()));
    });
  });
}
