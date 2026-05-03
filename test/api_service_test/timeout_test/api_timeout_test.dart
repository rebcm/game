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
    });

    test('should throw timeout error when API takes too long to respond', () async {
      dio.httpClientAdapter = dioAdapter;
      dio.options.connectTimeout = const Duration(seconds: 1);

      dioAdapter.onGet(
        'https://example.com/api/data',
        (server) => server.reply(200, {'data': 'success'}, delay: const Duration(seconds: 2)),
      );

      expect(
        () async => await ApiService(dio).fetchData('https://example.com/api/data'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
