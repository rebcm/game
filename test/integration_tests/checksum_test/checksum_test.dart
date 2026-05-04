import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checksum test', (tester) async {
    final expectedChecksum = await File('.github/docs/expected_checksum.txt').readAsString();
    final app = await tester.pumpWidget(MyApp()); // Assuming MyApp is the main app widget

    await tester.pumpAndSettle();

    final bytes = await File(Directory.current.path + '/build/app/outputs/flutter-apk/app-release.apk').readAsBytes();
    final checksum = sha256.convert(bytes).toString();

    expect(checksum, expectedChecksum.trim());
  });
}
