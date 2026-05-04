import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/services/content_loader.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Content Loader Integration Edge Cases', () {
    testWidgets('Test API timeout during content loading', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate API timeout
      expect(await ContentLoader.loadContent(timeout: Duration(seconds: 1)), throwsA(isA<TimeoutException>()));
    });

    testWidgets('Test missing local files during content loading', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate missing local files
      expect(await ContentLoader.loadLocalContent('non_existent_file.json'), throwsA(isA<FileSystemException>()));
    });

    testWidgets('Test invalid JSON parsing during content loading', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Simulate invalid JSON
      expect(() => ContentLoader.parseJson('invalid_json'), throwsA(isA<FormatException>()));
    });
  });
}
