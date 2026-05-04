import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:game/api/api.dart';
import 'package:mockito/mockito.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late Api api;

  setUp(() {
    dio = MockDio();
    api = Api(dio);
  });

  group('API Tests', () {
    test('should return data on successful request', () async {
      final dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      dioAdapter.onGet(
        'https://example.com/api/data',
        (server) => server.reply(200, {'data': 'success'}),
      );

      final response = await api.fetchData();
      expect(response, {'data': 'success'});
    });

    test('should throw error on failed request', () async {
      final dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;

      dioAdapter.onGet(
        'https://example.com/api/data',
        (server) => server.reply(404, {'error': 'not found'}),
      );

      expect(() async => await api.fetchData(), throwsA(isA<DioException>()));
    });
  });
}
