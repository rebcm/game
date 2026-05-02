import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:passdriver/services/http_client.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = getHttpClient();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('Testa requisição GET para API', () async {
    const path = '/test';
    const responseBody = {'message': 'Success'};

    dioAdapter.onGet(path, (server) => server.reply(200, responseBody));

    final response = await dio.get(path);

    expect(response.statusCode, 200);
    expect(response.data, responseBody);
  });
}
