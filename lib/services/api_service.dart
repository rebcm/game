import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<void> authenticateToken(String token) async {
    try {
      final response = await _dio.post('/auth', options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode != 200) {
        throw DioException(requestOptions: response.requestOptions, response: response);
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> uploadFile(String filePath, String token) async {
    try {
      final response = await _dio.post('/upload', data: FormData.fromMap({'file': await MultipartFile.fromFile(filePath)}), options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode != 201) {
        throw DioException(requestOptions: response.requestOptions, response: response);
      }
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> checkVersion(String version) async {
    try {
      final response = await _dio.post('/version-check', data: {'version': version});
      if (response.statusCode != 200) {
        throw DioException(requestOptions: response.requestOptions, response: response);
      }
    } on DioException catch (e) {
      rethrow;
    }
  }
}
