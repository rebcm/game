import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:rebcm/api/api_service.dart';
import 'package:http/testing.dart';

void main() {
  group('ApiService', () {
    test('getMundos retorna 200', () async {
      final apiService = ApiService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('[]', 200);
      });
      apiService.getMundos().then((response) {
        expect(response.statusCode, 200);
      });
    });

    test('getMundo retorna 200', () async {
      final apiService = ApiService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('{}', 200);
      });
      apiService.getMundo('1').then((response) {
        expect(response.statusCode, 200);
      });
    });

    test('criarMundo retorna 201', () async {
      final apiService = ApiService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('{}', 201);
      });
      apiService.criarMundo('novo mundo').then((response) {
        expect(response.statusCode, 201);
      });
    });

    test('atualizarMundo retorna 200', () async {
      final apiService = ApiService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('{}', 200);
      });
      apiService.atualizarMundo('1', 'mundo atualizado').then((response) {
        expect(response.statusCode, 200);
      });
    });

    test('deletarMundo retorna 204', () async {
      final apiService = ApiService();
      final mockHttpClient = MockClient((request) async {
        return http.Response('', 204);
      });
      apiService.deletarMundo('1').then((response) {
        expect(response.statusCode, 204);
      });
    });
  });
}
