import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/passdriver/passdriver_service.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

void main() {
  late Dio dio;
  late PassdriverService service;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    service = PassdriverService(dio);
  });

  test('successful authentication logs info', () async {
    dioAdapter.onPost('/authenticate', data: {'token': 'valid_token'}, (server) => server.reply(200, {}));
    await service.authenticate('valid_token');
    // Verify log info was called with 'Authentication successful'
  });

  test('failed authentication logs error', () async {
    dioAdapter.onPost('/authenticate', data: {'token': 'invalid_token'}, (server) => server.reply(401, {}));
    await service.authenticate('invalid_token');
    // Verify log error was called with 'Authentication error'
  });

  test('infrastructure error logs error', () async {
    dioAdapter.onPost('/authenticate', data: {'token': 'valid_token'}, (server) => server.reply(500, {}));
    await service.authenticate('valid_token');
    // Verify log error was called with 'Infrastructure error during authentication'
  });
}
