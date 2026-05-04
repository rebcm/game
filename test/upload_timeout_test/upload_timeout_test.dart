import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:game/api_service.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(mockDio);
  });

  test('should throw error on upload timeout', () async {
    when(mockDio.post(any, data: anyNamed('data'), options: anyNamed('options'))).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/upload'),
        type: DioExceptionType.connectionTimeout,
      ),
    );

    expect(() async => await apiService.uploadFile('large_file'), throwsA(isA<DioException>()));
  });
}
