import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Resolution Validation Test', () {
    testWidgets('validate UI on different resolutions', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 480)); // Low resolution
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(768, 1024)); // Medium resolution
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(1080, 1920)); // High resolution
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    });
  });
}
