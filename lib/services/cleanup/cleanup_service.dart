import 'package:dio/dio.dart';

class CleanupService {
  final Dio _dio;

  CleanupService(this._dio);

  Future<void> configureCleanupPolicy() async {
    try {
      final response = await _dio.post('/cleanup/configure');
      if (response.statusCode == 200) {
        print('Cleanup policy configured successfully');
      } else {
        print('Failed to configure cleanup policy: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error configuring cleanup policy: $e');
    }
  }
}
