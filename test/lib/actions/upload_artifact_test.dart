import 'package:flutter_test/flutter_test.dart';
import 'package:game/actions/upload_artifact.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  group('UploadArtifact', () {
    test('uploadApk success', () async {
      final uploadArtifact = UploadArtifact();
      final url = 'https://example.com/upload-apk';
      final filePath = 'path/to/app-release.apk';

      // Mock HTTP post
      http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/vnd.android.package-archive',
      }, body: File(filePath).readAsBytesSync());

      await uploadArtifact.uploadApk(url, filePath);
    });

    test('uploadApk failure', () async {
      final uploadArtifact = UploadArtifact();
      final url = 'https://example.com/upload-apk-failure';
      final filePath = 'path/to/app-release.apk';

      // Mock HTTP post failure
      http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/vnd.android.package-archive',
      }, body: File(filePath).readAsBytesSync());

      expect(() async => await uploadArtifact.uploadApk(url, filePath), throwsException);
    });

    test('uploadIpa success', () async {
      final uploadArtifact = UploadArtifact();
      final url = 'https://example.com/upload-ipa';
      final filePath = 'path/to/Runner.ipa';

      // Mock HTTP post
      http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/octet-stream',
      }, body: File(filePath).readAsBytesSync());

      await uploadArtifact.uploadIpa(url, filePath);
    });

    test('uploadIpa failure', () async {
      final uploadArtifact = UploadArtifact();
      final url = 'https://example.com/upload-ipa-failure';
      final filePath = 'path/to/Runner.ipa';

      // Mock HTTP post failure
      http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/octet-stream',
      }, body: File(filePath).readAsBytesSync());

      expect(() async => await uploadArtifact.uploadIpa(url, filePath), throwsException);
    });
  });
}
