import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiErrorHandler {
  static ApiError handleDioError(DioException e) {
    if (e.response?.data != null) {
      try {
        return ApiError.fromJson(e.response!.data);
      } catch (_) {
        // Fallback para erro desconhecido
        return ApiError(code: 'unknown', message: 'Erro desconhecido');
      }
    } else {
      return ApiError(code: 'network_error', message: 'Erro de rede');
    }
  }
}
