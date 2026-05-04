import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checksum test', (tester) async {
    await tester.pumpAndSettle();

    final appPath = Directory('build/app/outputs/flutter-apk/app-release.apk').path;
    final file = File(appPath);
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);

    final expectedChecksumFile = File('./.github/docs/expected_checksum.txt');
    final expectedChecksum = await expectedChecksumFile.readAsString();

    expect(digest.toString(), expectedChecksum.trim());
  });
}
