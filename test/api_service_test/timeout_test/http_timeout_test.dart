import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';
import 'package:game/api_service_test/mock_network/mock_http_adapter.dart';
import 'package:http/http.dart' as http;

void main() {
  late ApiService _apiService;
  late MockHttpAdapter _mockHttpAdapter;

  setUp(() {
    _mockHttpAdapter = MockHttpAdapter();
    _mockHttpAdapter.setTimeoutResponse();
    _apiService = ApiService(client: _mockHttpAdapter.getClient());
  });

  test('should return timeout error', () async {
    final response = await _apiService.fetchData();
    expect(response.isLeft(), true);
    expect(response.left.toString(), contains('Timeout'));
  });
}
