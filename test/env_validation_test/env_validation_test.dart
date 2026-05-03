import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:dotenv/dotenv.dart';

void main() {
  test('Validate environment variables', () async {
    await app.main();
    final env = Dotenv().env;
    final variables = [
      // List variables from wrangler.toml here
      'VARIABLE_NAME_1',
      'VARIABLE_NAME_2',
    ];
    for (var variable in variables) {
      expect(env[variable], isNotNull, reason: '$variable is not set');
    }
  });
}
