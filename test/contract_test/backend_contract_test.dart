import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/backend_service.dart';

void main() {
  group('Backend Contract Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late BackendService backendService;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      backendService = BackendService(dio);
    });

    test('Test API endpoint with valid response', () async {
      const path = '/api/endpoint';
      final responseData = {'key': 'value'};

      dioAdapter.onGet(
        path,
        (server) => server.reply(200, responseData),
      );

      final response = await backendService.getData();

      expect(response.statusCode, 200);
      expect(response.data, responseData);
    });

    test('Test API endpoint with error response', () async {
      const path = '/api/endpoint';
      const errorCode = 404;

      dioAdapter.onGet(
        path,
        (server) => server.reply(errorCode, null),
      );

      final response = await backendService.getData();

      expect(response.statusCode, errorCode);
    });
  });
}
