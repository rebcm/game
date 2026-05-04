import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Widget Tests', () {
    testWidgets('Text Overflow Test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Text('Test'),
          ),
        ),
      );
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
