import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/passdriver/passdriver_service.dart';
import 'package:game/services/passdriver/passdriver_exceptions.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http/http.dart' as http;

void main() {
  group('PassdriverService', () {
    late PassdriverService service;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      service = PassdriverService();
    });

    test('authenticate success', () async {
      dioAdapter.onPost(
        'https://example.com/authenticate',
        (request) => request.reply(200, {}),
      );

      final response = await service.authenticate('username', 'password');
      expect(response.statusCode, 200);
    });

    test('authenticate failure', () async {
      dioAdapter.onPost(
        'https://example.com/authenticate',
        (request) => request.reply(401, {}),
      );

      expect(
        () async => await service.authenticate('username', 'password'),
        throwsA(isA<PassdriverAuthenticationException>()),
      );
    });

    test('makeRequest success', () async {
      dioAdapter.onGet(
        'https://example.com/endpoint',
        (request) => request.reply(200, {}),
      );

      final response = await service.makeRequest('endpoint');
      expect(response.statusCode, 200);
    });

    test('makeRequest failure', () async {
      dioAdapter.onGet(
        'https://example.com/endpoint',
        (request) => request.reply(500, {}),
      );

      expect(
        () async => await service.makeRequest('endpoint'),
        throwsA(isA<PassdriverInfrastructureException>()),
      );
    });
  });
}
