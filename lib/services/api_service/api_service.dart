import 'package:http/http.dart' as http;
import 'package:game/services/api_service/interceptors/network_interceptor.dart';

class ApiService {
  final http.Client _client;
  final NetworkInterceptor _networkInterceptor;

  ApiService(this._client, this._networkInterceptor);

  Future<http.Response> makeRequest(http.Request request) async {
    return _networkInterceptor.interceptRequest(request);
  }
}
