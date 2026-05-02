import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify flutter web build', (tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyHomePage), findsOneWidget);
  });
}
