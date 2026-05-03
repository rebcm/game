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

  test('should return 200 OK when calling /healthcheck', () async {
    dioAdapter.onGet(
      '/healthcheck',
      (server) => server.reply(200, {'status': 'ok'}),
    );

    final response = await dio.get('/healthcheck');

    expect(response.statusCode, 200);
    expect(response.data, {'status': 'ok'});
  });

  test('should throw DioError when calling /nonexistent', () async {
    dioAdapter.onGet(
      '/nonexistent',
      (server) => server.reply(404, {'error': 'not found'}),
    );

    expect(() async => await dio.get('/nonexistent'), throwsA(isA<DioError>()));
  });
}
