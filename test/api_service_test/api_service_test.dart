import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service/api_service.dart';
import 'package:game/services/api_service/interceptors/network_interceptor.dart';

void main() {
  late DioAdapter _dioAdapter;
  late NetworkInterceptor _networkInterceptor;
  late ApiService _apiService;

  setUp(() {
    _dioAdapter = DioAdapter();
    _networkInterceptor = NetworkInterceptor(_dioAdapter);
    _apiService = ApiService(http.Client(), _networkInterceptor);
  });

  test('should make a successful request', () async {
    final request = http.Request('GET', Uri.parse('https://example.com/success'));
    final response = await _apiService.makeRequest(request);
    expect(response.statusCode, 200);
  });
}
