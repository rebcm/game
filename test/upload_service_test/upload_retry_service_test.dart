import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload_service/upload_retry_service.dart';
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
    dio.httpClientAdapter = dioAdapter;
    dioAdapter.onPost('/upload', (server) => server.reply(200, {'message': 'success'}));
    final service = UploadRetryService(dio);
    await expectLater(service.uploadWithRetry('test_file.txt', '/upload'), completes);
  });

  test('uploadWithRetry retries on connection error', () async {
    dio.httpClientAdapter = dioAdapter;
    dioAdapter.onPost('/upload', (server) => server.reply(500, {'message': 'error'}));
    final service = UploadRetryService(dio);
    await expectLater(() => service.uploadWithRetry('test_file.txt', '/upload'), throwsException);
  });

  test('uploadWithRetry throws after max retries', () async {
    dio.httpClientAdapter = dioAdapter;
    dioAdapter.onPost('/upload', (server) async {
      throw DioException(requestOptions: RequestOptions(path: '/upload'), type: DioExceptionType.connectionError);
    });
    final service = UploadRetryService(dio);
    await expectLater(() => service.uploadWithRetry('test_file.txt', '/upload'), throwsException);
  });
}
