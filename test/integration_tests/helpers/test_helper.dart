import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await _clearSharedPreferences();
  });

  testWidgets('Test setup is correct', (tester) async {
    await app.main();
    await tester.pumpAndSettle();
    expect(find.text('Rebeca'), findsOneWidget);
  });
}

Future<void> _clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
