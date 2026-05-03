import 'package:dio/dio.dart';

class UploadRetryLogic {
  final Dio _dio;

  UploadRetryLogic(this._dio);

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
        } else {
          rethrow;
        }
      }
    }

    throw Exception('Upload failed after $maxRetries retries');
  }
}
