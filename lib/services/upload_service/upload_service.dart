import 'package:dio/dio.dart';

class UploadService {
  final Dio _dio;

  UploadService(this._dio);

  Future<void> uploadData(List<int> data, String url) async {
    int chunkSize = 1024 * 1024; // 1MB
    int offset = 0;

    while (offset < data.length) {
      int end = (offset + chunkSize) < data.length ? (offset + chunkSize) : data.length;
      List<int> chunk = data.sublist(offset, end);

      try {
        await _uploadChunk(chunk, url, offset);
        offset += chunk.length;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionError) {
          await _retryUploadChunk(chunk, url, offset);
        } else {
          rethrow;
        }
      }
    }
  }

  Future<void> _uploadChunk(List<int> chunk, String url, int offset) async {
    await _dio.post(
      url,
      data: chunk,
      options: Options(
        headers: {
          'Content-Range': 'bytes $offset-${offset + chunk.length - 1}',
        },
      ),
    );
  }

  Future<void> _retryUploadChunk(List<int> chunk, String url, int offset) async {
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        await _uploadChunk(chunk, url, offset);
        return;
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionError) {
          retryCount++;
        } else {
          rethrow;
        }
      }
    }
    throw Exception('Failed to upload chunk after 3 retries');
  }
}
