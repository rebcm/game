import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checksum test', (tester) async {
    await tester.pumpAndSettle();

    final appPath = Directory.current.path;
    final binaryPath = '$appPath/build/app/outputs/flutter-apk/app-release.apk';
    final file = File(binaryPath);
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);

    final expectedChecksumPath = '$appPath/.github/docs/expected_checksum.txt';
    final expectedChecksumFile = File(expectedChecksumPath);
    final expectedChecksum = await expectedChecksumFile.readAsString();

    expect(digest.toString(), expectedChecksum.trim());
  });
}
