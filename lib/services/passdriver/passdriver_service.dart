import 'package:dio/dio.dart';
import 'package:game/utils/logger/logger.dart';

class PassdriverService {
  final Dio _dio;

  PassdriverService(this._dio);

  Future<void> authenticate(String token) async {
    try {
      final response = await _dio.post('/authenticate', data: {'token': token});
      if (response.statusCode == 200) {
        Logger.logInfo('Authentication successful');
      } else {
        Logger.logError('Authentication failed', response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        Logger.logError('Infrastructure error during authentication', e.message);
      } else if (e.response?.statusCode == 401) {
        Logger.logError('Authentication error', e.message);
      } else {
        Logger.logError('Payload error during authentication', e.message);
      }
    } catch (e) {
      Logger.logError('Unexpected error during authentication', e);
    }
  }
}
