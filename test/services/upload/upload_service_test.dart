import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload/upload_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'dart:io';

void main() {
  group('UploadService', () {
    test('uploadFile success', () async {
      var dioAdapter = DioAdapter();
      dioAdapter.onPost(
        'https://example.com/upload',
        (server) => server.reply(200, {}),
      );

      var uploadService = UploadService();
      var file = File('test_file.txt');
      await file.writeAsString('Test content');

      await uploadService.uploadFile(file);
      // Verify the upload was successful
    });

    test('uploadFile failure', () async {
      var dioAdapter = DioAdapter();
      dioAdapter.onPost(
        'https://example.com/upload',
        (server) => server.reply(500, {}),
      );

      var uploadService = UploadService();
      var file = File('test_file.txt');
      await file.writeAsString('Test content');

      await uploadService.retryUpload(file);
      // Verify the retry logic
    });
  });
}
