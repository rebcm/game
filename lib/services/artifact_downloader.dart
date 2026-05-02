import 'package:http/http.dart' as http;
import 'dart:io';

class ArtifactDownloader {
  final http.Client _client;

  ArtifactDownloader(this._client);

  Future<bool> downloadArtifact(String url, String destination) async {
    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount <= maxRetries) {
      try {
        final response = await _client.get(Uri.parse(url));
        if (response.statusCode == 200) {
          File file = File(destination);
          await file.writeAsBytes(response.bodyBytes);
          return true;
        } else {
          retryCount++;
          await Future.delayed(Duration(seconds: 2));
        }
      } on SocketException {
        retryCount++;
        await Future.delayed(Duration(seconds: 2));
      } on http.ClientException {
        retryCount++;
        await Future.delayed(Duration(seconds: 2));
      }
    }
    return false;
  }
}
