import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';
import 'package:game/api_service_test/mock_network/mock_http_adapter.dart';
import 'package:dio/dio.dart';

void main() {
  late ApiService _apiService;
  late MockHttpAdapter _mockHttpAdapter;

  setUp(() {
    _mockHttpAdapter = MockHttpAdapter();
    _apiService = ApiService(Dio()..httpClientAdapter = _mockHttpAdapter.dioAdapter);
  });

  test('should return error message when timeout occurs', () async {
    _mockHttpAdapter.setTimeoutError();
    final response = await _apiService.fetchData(delay: true);
    expect(response.isLeft(), true);
    expect(response.left.toString(), contains('Timeout'));
  });

  test('should return success message when data is fetched', () async {
    _mockHttpAdapter.setSuccessResponse();
    final response = await _apiService.fetchData();
    expect(response.isRight(), true);
    expect(response.right.toString(), contains('Success'));
  });
}
