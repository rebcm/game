import 'package:flutter_test/flutter_test.dart';
import 'package:game/passdriver/integration_plan/content_integration_plan.dart';

void main() {
  group('ContentIntegrationPlan', () {
    test('initial content source is local', () {
      final plan = ContentIntegrationPlan();
      expect(plan.contentSource, 'local');
    });

    test('setContentSource updates content source', () {
      final plan = ContentIntegrationPlan();
      plan.setContentSource('api');
      expect(plan.contentSource, 'api');
    });
  });
}
