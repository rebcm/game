import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:passdriver/features/api_test/data/api_test_repository.dart';

void main() {
  group('API Test Repository', () {
    test('should return success when API call is successful', () async {
      final repository = ApiTestRepository(http.Client());
      final result = await repository.makeApiCall();
      expect(result.isRight(), true);
    });

    test('should return failure when API call fails', () async {
      final repository = ApiTestRepository(http.Client());
      final result = await repository.makeApiCallWithError();
      expect(result.isLeft(), true);
    });
  });
}
