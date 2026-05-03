import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/client/openapi_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('OpenAPI Client Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
    });

    test('should return correct response when API call is successful', () async {
      const path = '/test-endpoint';
      const responseBody = {'message': 'Success'};

      dio.httpClientAdapter = dioAdapter;
      dioAdapter.onGet(
        path,
        (server) => server.reply(200, responseBody),
      );

      final response = await dio.get(path);

      expect(response.statusCode, 200);
      expect(response.data, responseBody);
    });

    test('should throw exception when API call fails', () async {
      const path = '/test-endpoint';

      dio.httpClientAdapter = dioAdapter;
      dioAdapter.onGet(
        path,
        (server) => server.reply(404, null),
      );

      expect(() async => await dio.get(path), throwsA(isA<DioError>()));
    });
  });
}
