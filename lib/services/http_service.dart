import 'package:http/http.dart' as http;
import 'package:game/services/logging/error_logger.dart';

class HttpService {
  Future<http.Response> makeRequest(Uri uri) async {
    try {
      return await http.get(uri);
    } on http.ClientException catch (e, stackTrace) {
      ErrorLogger.logError(InfrastructureException(e.message), stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      ErrorLogger.logError(e, stackTrace);
      rethrow;
    }
  }
}
