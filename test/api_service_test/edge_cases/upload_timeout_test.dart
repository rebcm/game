import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ApiService apiService;
  late MockDio dio;

  setUp(() {
    dio = MockDio();
    apiService = ApiService(dio);
  });

  test('should throw exception on upload timeout', () async {
    when(dio.post(any, data: anyNamed('data'))).thenThrow(DioException(
      requestOptions: RequestOptions(path: '/upload'),
      type: DioExceptionType.connectionTimeout,
    ));

    expect(() async => await apiService.uploadFile('large_file', 'token'), throwsA(isA<DioException>()));
  });
}
