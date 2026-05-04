import 'package:flutter_test/flutter_test.dart';
import 'package:game/upload_client.dart';
import 'package:dio/dio.dart';

void main() {
  test('Upload timeout test', () async {
    final dio = Dio();
    final client = UploadClient(dio);
    dio.options.connectTimeout = const Duration(milliseconds: 100);
    try {
      await client.uploadLargeFile();
      fail('Should have thrown an exception');
    } on DioException catch (e) {
      expect(e.type, DioExceptionType.connectionTimeout);
    }
  });
}
