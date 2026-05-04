import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checksum test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final ByteData data = await rootBundle.load('assets/rebeca_animation.riv');
    final checksum = sha256.convert(data.buffer.asUint8List());

    final expectedChecksum = File('./.github/docs/expected_checksum.txt').readAsStringSync().trim();

    expect(checksum.toString(), expectedChecksum);
  });
}
