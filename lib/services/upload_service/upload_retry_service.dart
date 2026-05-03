import 'package:http/http.dart' as http;

class UploadRetryService {
  final http.Client _httpClient;

  UploadRetryService(this._httpClient);

  Future<bool> retryUpload(String url, String filePath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        return await _retryUpload(request);
      }
    } catch (e) {
      return await _retryUpload(http.MultipartRequest('POST', Uri.parse(url)));
    }
  }

  Future<bool> _retryUpload(http.MultipartRequest request) async {
    int retryCount = 0;
    while (retryCount < 3) {
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          return true;
        }
      } catch (e) {
        retryCount++;
        await Future.delayed(Duration(seconds: retryCount * 2));
      }
    }
    return false;
  }
}
