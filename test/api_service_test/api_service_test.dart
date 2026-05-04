import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:game/services/api_service.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('API Service Test', () {
    late ApiService apiService;
    late MockDio dio;

    setUp(() {
      dio = MockDio();
      apiService = ApiService(dio);
    });

    test('test API service methods', () async {
      // Implement test logic here for API service methods
      // For example, testing if the API service correctly handles responses from the Dio client
    });
  });
}
