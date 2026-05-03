import 'package:dio/dio.dart';

class UploadRetryService {
  final Dio _dio;

  UploadRetryService(this._dio);

  Future<void> uploadWithRetry(String filePath, String uploadUrl) async {
    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        await _dio.post(uploadUrl, data: await MultipartFile.fromFile(filePath));
        return;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionError) {
          retryCount++;
          await Future.delayed(Duration(seconds: retryCount * 2));
        } else {
          rethrow;
        }
      }
    }

    throw Exception('Upload failed after $maxRetries retries');
  }
}
