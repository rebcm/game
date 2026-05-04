import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      try {
        final apiError = ApiErrorModel.fromJson(err.response!.data);
        return handler.next(DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: apiError,
        ));
      } catch (_) {
        // Not a standard error response, proceed as usual
      }
    }
    return handler.next(err);
  }
}
