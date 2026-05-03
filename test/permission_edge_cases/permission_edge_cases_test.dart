import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Permission Edge Cases', () {
    testWidgets('Permanently denied permission', (tester) async {
      await tester.pumpWidget(MyApp());
      // Simulate permanent denial of permission
      await Permission.microphone.request();
      await Permission.microphone.permanentlyDenied = true;
      // Validate app behavior
      expect(find.text('Permission denied'), findsOneWidget);
    });

    testWidgets('Device without microphone hardware', (tester) async {
      await tester.pumpWidget(MyApp());
      // Simulate device without microphone
      await Permission.microphone.isDenied.then((value) => expect(value, true));
      // Validate app behavior
      expect(find.text('No microphone available'), findsOneWidget);
    });

    testWidgets('Permission revoked while app is open', (tester) async {
      await tester.pumpWidget(MyApp());
      // Grant permission initially
      await Permission.microphone.request();
      // Revoke permission while app is open
      await Permission.microphone.revoke();
      // Validate app behavior
      expect(find.text('Permission revoked'), findsOneWidget);
    });
  });
}
