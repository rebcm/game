import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:game/services/api_service/mocks/storage_limit_mock.dart';
import 'package:dio/dio.dart';

void main() {
  late Dio _dio;
  late DioAdapter _dioAdapter;
  late StorageLimitMock _storageLimitMock;

  setUp(() {
    _dio = Dio();
    _dioAdapter = DioAdapter(dio: _dio);
    _dio.httpClientAdapter = _dioAdapter;
    _storageLimitMock = StorageLimitMock(_dioAdapter);
  });

  test('storage limit exceeded', () async {
    _storageLimitMock.mockStorageLimitExceeded();
    final response = await _dio.get('https://example.com/storage-limit');
    expect(response.statusCode, 403);
    expect(response.data['error'], 'Storage limit exceeded');
  });

  test('storage within limit', () async {
    _storageLimitMock.mockStorageWithinLimit();
    final response = await _dio.get('https://example.com/storage-limit');
    expect(response.statusCode, 200);
    expect(response.data['available'], true);
  });
}
