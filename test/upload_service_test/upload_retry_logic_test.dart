import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload_service/upload_retry_logic.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('uploadWithRetry succeeds on first attempt', () async {
    dioAdapter.onPost('/upload', (server) => server.reply(200, 'Success'));
    final uploadRetryLogic = UploadRetryLogic(dio);

    await expectLater(uploadRetryLogic.uploadWithRetry('test_file.txt', '/upload'), completes);
  });

  test('uploadWithRetry retries on connection error', () async {
    dioAdapter.onPost('/upload', (server) => server.reply(500, 'Error'));
    final uploadRetryLogic = UploadRetryLogic(dio);

    await expectLater(uploadRetryLogic.uploadWithRetry('test_file.txt', '/upload'), throwsException);
  });
}
