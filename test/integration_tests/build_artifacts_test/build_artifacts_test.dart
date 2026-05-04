import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Build artifacts path validation', (tester) async {
    final buildWebDir = Directory('build/web');
    expect(buildWebDir.existsSync(), true, reason: 'build/web directory should exist');
    expect(buildWebDir.listSync().isNotEmpty, true, reason: 'build/web directory should not be empty');
  });
}
