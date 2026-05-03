import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('ApiClient Test', () {
    test('Test getEndpoint', () async {
      final dio = Dio();
      final dioAdapter = DioAdapter(dio: dio);

      dio.httpClientAdapter = dioAdapter;

      dioAdapter.onGet(
        'https://example.com/api/endpoint',
        (server) => server.reply(200, {'message': 'Success'}),
      );

      final apiClient = ApiClient(dio);
      final response = await apiClient.getEndpoint();

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'Success'});
    });
  });
}
