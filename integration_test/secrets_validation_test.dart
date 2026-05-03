import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate secrets configuration', (tester) async {
    await dotenv.load();
    expect(dotenv.env['SECRET_KEY'], isNotNull);
    expect(dotenv.env['SECRET_TOKEN'], isNotNull);
  });
}
