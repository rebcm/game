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

  test('should throw error on API token authentication failure', () async {
    when(mockDio.post(any, options: anyNamed('options'))).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/auth'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/auth'),
        ),
      ),
    );

    expect(() async => await apiService.authenticate('invalid_token'), throwsA(isA<DioException>()));
  });
}
