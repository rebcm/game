import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/dicas_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('deve retornar lista de dicas', () async {
    final dicasService = DicasService();
    final client = MockClient((request) async {
      return http.Response('{"dicas": [{"id": 1, "conteudo": "Dica 1"}]}', 200);
    });
    http.Client clientOriginal = http.Client();
    http.Client = () => client;

    final dicas = await dicasService.getDicas();

    expect(dicas, isA<List<Dica>>());
    expect(dicas.length, 1);

    http.Client = () => clientOriginal;
  });

  test('deve lançar exceção quando statusCode não é 200', () async {
    final dicasService = DicasService();
    final client = MockClient((request) async {
      return http.Response('Not Found', 404);
    });
    http.Client clientOriginal = http.Client();
    http.Client = () => client;

    expect(() async => await dicasService.getDicas(), throwsException);

    http.Client = () => clientOriginal;
  });
}
