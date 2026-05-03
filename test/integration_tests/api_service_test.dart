import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/api_service.dart';

void main() {
  group('ApiService Tests', () {
    test('getEndpoint1 returns 200', () async {
      final apiService = ApiService();
      final response = await apiService.getEndpoint1();
      expect(response.statusCode, 200);
    });

    test('postEndpoint2 returns 201', () async {
      final apiService = ApiService();
      final response = await apiService.postEndpoint2({'key': 'value'});
      expect(response.statusCode, 201);
    });
  });
}
