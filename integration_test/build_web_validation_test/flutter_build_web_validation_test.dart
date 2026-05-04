import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Flutter build web validation test', (tester) async {
    final result = await Process.run('flutter', ['build', 'web']);
    expect(result.exitCode, 0);
    expect(Directory('build/web').existsSync(), true);
  });
}
