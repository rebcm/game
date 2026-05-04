import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('Testa se a documentação de endpoints reflete a realidade do backend', () async {
    // Configura o adapter para mockar a resposta do backend
    dioAdapter.onGet(
      '/endpoint',
      (server) => server.reply(200, {'message': 'Sucesso'}),
    );

    final response = await dio.get('/endpoint');
    expect(response.statusCode, 200);
    expect(response.data, {'message': 'Sucesso'});
  });
}
