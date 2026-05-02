import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  testWidgets('Secrets validation test', (tester) async {
    final apiKey = dotenv.env['API_KEY'];
    final secretKey = dotenv.env['SECRET_KEY'];

    expect(apiKey, isNotNull);
    expect(secretKey, isNotNull);
    expect(apiKey, isNotEmpty);
    expect(secretKey, isNotEmpty);
  });
}
