import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_service.freezed.dart';

@Freezed()
class ApiResponse with _$ApiResponse {
  const factory ApiResponse.success(String message) = _Success;
  const factory ApiResponse.error(String message) = _Error;
}

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Either<String, String>> fetchData({bool delay = false}) async {
    try {
      final response = await _dio.get('https://example.com/api/data', queryParameters: {'delay': delay});
      if (response.statusCode == 200) {
        return ApiResponse.success(response.data['message']);
      } else {
        return ApiResponse.error(response.data['message']);
      }
    } on DioException catch (e) {
      return ApiResponse.error(e.message ?? 'Unknown error');
    }
  }
}
