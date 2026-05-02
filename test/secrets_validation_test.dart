import 'package:flutter_test/flutter_test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  test('Secrets are loaded correctly', () async {
    final env = DotEnv();
    await env.load();
    expect(env['SECRET_KEY'], isNotNull);
    expect(env['SECRET_KEY'], isNotEmpty);
  });
}
