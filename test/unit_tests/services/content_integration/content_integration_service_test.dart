import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/content_integration/content_integration_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('ContentIntegrationService', () {
    test('fetchTips returns tips when the response is 200', () async {
      final mockHttpClient = MockClient((request) async {
        return http.Response('{"tips": ["tip1", "tip2"]}', 200);
      });

      final service = ContentIntegrationService();
      service.fetchTips().then((tips) {
        expect(tips, '{"tips": ["tip1", "tip2"]}');
      });
    });

    test('fetchTips throws an exception when the response is not 200', () async {
      final mockHttpClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final service = ContentIntegrationService();
      expect(service.fetchTips(), throwsException);
    });
  });
}
