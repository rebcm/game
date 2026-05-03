import 'dart:io';
import 'package:http/http.dart' as http;

class UploadService {
  Future<void> uploadFile(File file) async {
    var uri = Uri.parse('https://example.com/upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Upload successful');
    } else {
      print('Upload failed');
      // Retry logic will be implemented here
    }
  }

  Future<void> retryUpload(File file) async {
    // Implement retry logic using exponential backoff
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        await uploadFile(file);
        break;
      } catch (e) {
        retryCount++;
        await Future.delayed(Duration(seconds: retryCount * 2));
      }
    }
  }
}
