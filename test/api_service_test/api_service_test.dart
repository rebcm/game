import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:game/services/api_service/api_service.dart';

void main() {
  group('ApiService Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late ApiService apiService;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      apiService = ApiService(dio);
    });

    test('should return successful response', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(200, {'data': 'artefato'}),
      );

      final response = await apiService.getArtefato();
      expect(response.statusCode, 200);
      expect(response.data, {'data': 'artefato'});
    });

    test('should throw exception on 401', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(401, {}),
      );

      expect(() async => await apiService.getArtefato(), throwsException);
    });

    test('should throw exception on 403', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(403, {}),
      );

      expect(() async => await apiService.getArtefato(), throwsException);
    });

    test('should throw exception on 507', () async {
      dioAdapter.onGet(
        'https://example.com/api/artefato',
        (server) => server.reply(507, {}),
      );

      expect(() async => await apiService.getArtefato(), throwsException);
    });
  });
}
