import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:construcao_criativa/features/world_api/models/world_payload_model.dart';
import 'package:construcao_criativa/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test World API Integration', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Implement your test logic here
    // For example, test the world payload model
    final worldPayload = WorldPayloadModel(data: 'test_data');
    expect(worldPayload.data, 'test_data');
  });
}
