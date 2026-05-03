import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/services/persistence_service/persistence_service.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test state reset persistence', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PersistenceService()),
        ],
        child: app.MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Simulate state reset
    final persistenceService = tester.binding.firstWidget<MultiProvider>(find.byType(MultiProvider)).providers.first.read<PersistenceService>();
    persistenceService.reset();
    await tester.pumpAndSettle();

    // Verify persistence
    expect(find.text('Expected text after state reset'), findsOneWidget);
  });
}
