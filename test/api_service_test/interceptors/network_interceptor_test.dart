import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service/interceptors/network_interceptor.dart';

void main() {
  late DioAdapter _dioAdapter;
  late NetworkInterceptor _networkInterceptor;

  setUp(() {
    _dioAdapter = DioAdapter();
    _networkInterceptor = NetworkInterceptor(_dioAdapter);
  });

  test('should return 408 on timeout', () async {
    _networkInterceptor.simulateTimeout();
    final request = http.Request('GET', Uri.parse('https://example.com/timeout'));
    final response = await _networkInterceptor.interceptRequest(request);
    expect(response.statusCode, 408);
  });

  test('should return 500 on server error', () async {
    _networkInterceptor.simulateServerError();
    final request = http.Request('GET', Uri.parse('https://example.com/5xx'));
    final response = await _networkInterceptor.interceptRequest(request);
    expect(response.statusCode, 500);
  });
}
