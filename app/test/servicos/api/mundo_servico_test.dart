import 'package:flutter_test/flutter_test.dart';
import 'package:game/servicos/api/mundo_servico.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('MundoServico', () {
    test('criarMundo retorna true em sucesso', () async {
      final mockHttpClient = MockClient((request) async {
        return http.Response('', 201);
      });
      final servico = MundoServico();
      servico._cliente = mockHttpClient;

      final resultado = await servico.criarMundo('novo_mundo');
      expect(resultado, true);
    });

    test('limiteMundos retorna o limite', () async {
      final mockHttpClient = MockClient((request) async {
        return http.Response('5', 200);
      });
      final servico = MundoServico();
      servico._cliente = mockHttpClient;

      final limite = await servico.limiteMundos();
      expect(limite, 5);
    });
  });
}
