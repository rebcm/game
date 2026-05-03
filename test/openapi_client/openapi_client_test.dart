import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/client/openapi_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('OpenAPI Client Test', () async {
    dio.httpClientAdapter = dioAdapter;

    const path = '/example';
    const statusCode = 200;
    const responseData = {'message': 'Success'};

    dioAdapter.onGet(
      path,
      (server) => server.reply(statusCode, responseData),
    );

    final response = await dio.get(path);

    expect(response.statusCode, statusCode);
    expect(response.data, responseData);
  });
}
