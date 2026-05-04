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
    final ByteData? data = await binding.convertFlutterSurfaceToImage();
    final Uint8List bytes = data!.buffer.asUint8List();

    // Calculate checksum
    final checksum = bytes.map((e) => e.toRadixString(16)).join();
    expect(checksum, 'EXPECTED_CHECKSUM_VALUE');
  });
}
