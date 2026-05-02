import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:dotenv/dotenv.dart';

void main() {
  test('Secrets are loaded', () async {
    final env = DotEnv();
    await env.load();
    expect(env['MY_SECRET'], isNotNull);
  });
}
