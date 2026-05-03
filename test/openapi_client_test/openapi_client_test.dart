import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';
import 'package:game/openapi/client/openapi_client.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('should return correct response when API call is successful', () async {
    const path = '/test-endpoint';
    final responseData = {'message': 'Success'};

    dioAdapter.onGet(
      path,
      (server) => server.reply(200, responseData),
    );

    final client = OpenAPIClient(dio);
    final response = await client.get(path);

    expect(response.statusCode, 200);
    expect(response.data, responseData);
  });

  test('should throw exception when API call fails', () async {
    const path = '/test-endpoint';

    dioAdapter.onGet(
      path,
      (server) => server.reply(404, {'message': 'Not Found'}),
    );

    final client = OpenAPIClient(dio);

    expect(() async => await client.get(path), throwsA(isA<DioError>()));
  });
}
