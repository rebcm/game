import 'package:dio/dio.dart';

class StorageService {
  final Dio _dio;

  StorageService({Dio? dio}) : _dio = dio ?? Dio();

  Future<void> store(String key, dynamic value) async {
    if (value is List && value.length > 100000) {
      throw StorageException('Value too large');
    }
    try {
      await _dio.post('/storage', data: {'key': key, 'value': value});
    } on DioException catch (e) {
      throw StorageException('Failed to store data: ${e.message}');
    }
  }

  Future<dynamic> retrieve(String key) async {
    try {
      final response = await _dio.get('/storage/$key');
      return response.data;
    } on DioException catch (e) {
      throw StorageException('Failed to retrieve data: ${e.message}');
    }
  }
}

class StorageException implements Exception {
  final String message;

  StorageException(this.message);
}
