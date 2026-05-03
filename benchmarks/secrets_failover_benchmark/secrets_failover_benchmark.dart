import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  testWidgets('Benchmark secrets failover', (tester) async {
    await dotenv.load(fileName: '.env.example');
    final stopwatch = Stopwatch()..start();
    try {
      await app.main();
    } catch (e) {
      expect(e.toString(), contains('Missing required environment variables'));
    }
    print('Secrets failover benchmark: ${stopwatch.elapsed.inMilliseconds}ms');
  });
}
