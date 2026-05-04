import 'package:http/http.dart' as http;

class R2Service {
  String? _accountId;
  String? _bucketName;
  String? _accessKeyId;
  String? _secretAccessKey;
  bool _useSandbox = false;

  Future<void> init({bool useSandbox = false}) async {
    _useSandbox = useSandbox;
    // Load config from .env or other secure storage
    // For demonstration, assuming direct assignment
    _accountId = 'your_account_id';
    _bucketName = 'your_bucket_name';
    _accessKeyId = 'your_access_key_id';
    _secretAccessKey = 'your_secret_access_key';
  }

  Future<void> uploadFile(String fileName, String content) async {
    if (_useSandbox) {
      // Implement sandbox upload logic or mock
      print('Uploading $fileName to sandbox: $content');
    } else {
      final url = Uri.parse('https://$_accountId.r2.cloudflarestorage.com/$fileName');
      final response = await http.put(url, headers: {
        'Authorization': 'Bearer your_token',
      }, body: content);
      if (response.statusCode != 200) {
        throw Exception('Failed to upload file');
      }
    }
  }

  Future<bool> fileExists(String fileName) async {
    if (_useSandbox) {
      // Implement sandbox exists logic or mock
      print('Checking if $fileName exists in sandbox');
      return true; // Mock return
    } else {
      final url = Uri.parse('https://$_accountId.r2.cloudflarestorage.com/$fileName');
      final response = await http.head(url, headers: {
        'Authorization': 'Bearer your_token',
      });
      return response.statusCode == 200;
    }
  }

  Future<void> deleteFile(String fileName) async {
    if (_useSandbox) {
      // Implement sandbox delete logic or mock
      print('Deleting $fileName from sandbox');
    } else {
      final url = Uri.parse('https://$_accountId.r2.cloudflarestorage.com/$fileName');
      final response = await http.delete(url, headers: {
        'Authorization': 'Bearer your_token',
      });
      if (response.statusCode != 204) {
        throw Exception('Failed to delete file');
      }
    }
  }
}
