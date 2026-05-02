import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Upload stress test', (tester) async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    dioAdapter.onPost(
      'https://construcao-criativa.workers.dev/upload',
      (server) => server.reply(
        200,
        {'message': 'success'},
        delay: const Duration(seconds: 1),
      ),
      data: any,
    );

    final largeFile = List.generate(1024 * 1024 * 5, (index) => index % 256);

    final response = await dio.post(
      'https://construcao-criativa.workers.dev/upload',
      data: largeFile,
    );

    expect(response.statusCode, 200);
    expect(response.data['message'], 'success');
  });

  testWidgets('Upload stress test with multiple files', (tester) async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    dioAdapter.onPost(
      'https://construcao-criativa.workers.dev/upload',
      (server) => server.reply(
        200,
        {'message': 'success'},
        delay: const Duration(seconds: 1),
      ),
      data: any,
    );

    final largeFiles = List.generate(
      5,
      (index) => List.generate(1024 * 1024, (index) => index % 256),
    );

    for (var file in largeFiles) {
      final response = await dio.post(
        'https://construcao-criativa.workers.dev/upload',
        data: file,
      );

      expect(response.statusCode, 200);
      expect(response.data['message'], 'success');
    }
  });
}
