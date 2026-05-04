import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Checksum test', (tester) async {
    final appExecutable = File('build/app/outputs/flutter-apk/app-release.apk');
    if (!await appExecutable.exists()) {
      throw Exception('App executable not found');
    }

    final bytes = await appExecutable.readAsBytes();
    final checksum = sha256.convert(bytes);

    final expectedChecksumFile = File('.github/docs/expected_checksum.txt');
    if (!await expectedChecksumFile.exists()) {
      throw Exception('Expected checksum file not found');
    }

    final expectedChecksum = await expectedChecksumFile.readAsString();
    expect(checksum.toString(), expectedChecksum.trim());
  });
}
