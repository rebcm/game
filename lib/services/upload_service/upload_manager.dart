import 'package:http/http.dart' as http;
import 'package:game/services/upload_service/upload_retry_manager.dart';

class UploadManager {
  final UploadRetryManager _uploadRetryManager;

  UploadManager(this._uploadRetryManager);

  Future<bool> uploadData(List<int> data) async {
    return _uploadRetryManager.retryUpload(() async {
      final response = await http.post(Uri.parse('https://example.com/upload'), body: data);
      return response.statusCode == 200;
    });
  }
}
