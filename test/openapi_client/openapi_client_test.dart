import 'package:flutter_test/flutter_test.dart';
import 'package:game/openapi/client/openapi_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
  });

  test('should return 200 for valid request', () async {
    dioAdapter.onGet(
      'https://example.com/api/endpoint',
      (server) => server.reply(200, {'message': 'success'}),
    );

    final response = await dio.get('https://example.com/api/endpoint');

    expect(response.statusCode, 200);
    expect(response.data, {'message': 'success'});
  });

  test('should throw exception for invalid request', () async {
    dioAdapter.onGet(
      'https://example.com/api/endpoint',
      (server) => server.reply(404, {'message': 'not found'}),
    );

    expect(() async => await dio.get('https://example.com/api/endpoint'), throwsA(isA<DioError>()));
  });
}
