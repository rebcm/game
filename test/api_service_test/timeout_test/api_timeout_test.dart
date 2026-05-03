import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service.dart';

void main() {
  group('API Timeout Test', () {
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
    });

    test('should throw timeout error when API takes too long to respond', () async {
      const url = 'https://example.com/api/data';
      dioAdapter.onGet(
        url,
        (server) => server.reply(200, {'data': 'some data'}, delay: const Duration(seconds: 10)),
      );

      expect(
        () async => await ApiService(dio: dio).fetchData(url),
        throwsA(isA<DioException>()),
      );
    });
  });
}
