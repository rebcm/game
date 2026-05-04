import 'package:dio/dio.dart';
import 'package:game/services/api_service/interceptors/mock_api_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException catch (e) {
      // Handle Dio exceptions
      rethrow;
    }
  }

  factory ApiService.mocked() {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    final interceptor = MockApiInterceptor(dio, dioAdapter);
    interceptor.setupMocks();
    dio.interceptors.add(interceptor);
    return ApiService(dio);
  }
}
import 'package:dio/dio.dart';
import 'error_handling/api_error_interceptor.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.interceptors.add(ApiErrorInterceptor());
  }

  // Existing methods...
}
