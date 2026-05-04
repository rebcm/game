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

  test('should throw exception on API token authentication failure', () async {
    when(dio.post(any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: '/auth'),
      response: Response(statusCode: 401, requestOptions: RequestOptions(path: '/auth')),
    ));

    expect(() async => await apiService.authenticateToken('invalid_token'), throwsA(isA<DioException>()));
  });
}
