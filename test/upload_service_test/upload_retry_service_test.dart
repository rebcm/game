import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload_service/upload_retry_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('UploadRetryService', () {
    late http.Client httpClient;
    late DioAdapter dioAdapter;

    setUp(() {
      httpClient = http.Client();
      dioAdapter = DioAdapter();
    });

    test('successful upload', () async {
      var service = UploadRetryService(httpClient);
      var result = await service.retryUpload('https://example.com/upload', 'test_file.txt');
      expect(result, true);
    });

    test('failed upload with retry', () async {
      var service = UploadRetryService(httpClient);
      var result = await service.retryUpload('https://example.com/upload-fail', 'test_file.txt');
      expect(result, false);
    });

    test('upload with exception', () async {
      var service = UploadRetryService(httpClient);
      var result = await service.retryUpload('https://example.com/upload-exception', 'test_file.txt');
      expect(result, false);
    });
  });
}
