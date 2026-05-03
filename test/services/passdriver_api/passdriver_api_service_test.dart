import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/passdriver_api/passdriver_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('PassdriverApiService', () {
    test('exemploEndpoint sucesso', () async {
      final dioAdapter = DioAdapter();
      final dio = Dio();
      dio.httpClientAdapter = dioAdapter;

      final response = http.Response('{"mensagem": "Sucesso"}', 200);

      final service = PassdriverApiService();
      final result = await service.exemploEndpoint();

      expect(result.statusCode, 200);
      expect(result.body, '{"mensagem": "Sucesso"}');
    });

    test('exemploEndpoint erro', () async {
      final dioAdapter = DioAdapter();
      final dio = Dio();
      dio.httpClientAdapter = dioAdapter;

      final response = http.Response('{"mensagem": "Erro interno"}', 500);

      final service = PassdriverApiService();
      final result = await service.exemploEndpoint();

      expect(result.statusCode, 500);
      expect(result.body, '{"mensagem": "Erro interno"}');
    });
  });
}
