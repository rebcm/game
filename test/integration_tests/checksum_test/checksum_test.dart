import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checksum test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    final ByteData? data = await binding.takeScreenshot('screenshot');
    final checksum = data!.buffer.asUint8List().toString();

    final expectedChecksum = await rootBundle.loadString('.github/docs/expected_checksum.txt');
    expect(checksum, expectedChecksum.trim());
  });
}
