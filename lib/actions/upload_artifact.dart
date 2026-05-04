import 'package:http/http.dart' as http;
import 'dart:io';

class UploadArtifact {
  Future<void> uploadApk(String url, String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/vnd.android.package-archive',
    }, body: bytes);

    if (response.statusCode != 201) {
      throw Exception('Failed to upload APK');
    }
  }

  Future<void> uploadIpa(String url, String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/octet-stream',
    }, body: bytes);

    if (response.statusCode != 201) {
      throw Exception('Failed to upload IPA');
    }
  }
}
