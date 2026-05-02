import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadChunk with ChangeNotifier {
  Future<void> uploadChunk(String chunk, String fileId) async {
    final response = await http.post(Uri.parse('https://example.com/upload/'),
      headers: {'Content-Type': 'application/octet-stream'},
      body: chunk,
    );

    if (response.statusCode != 200) {
      // marca o estado como 'incompleto' no provider
      notifyListeners();
    }
  }

  Future<void> cancelUpload(String fileId) async {
    // remove o metadado correspondente no D1
    final response = await http.delete(Uri.parse('https://example.com/upload/'));
    if (response.statusCode != 200) {
      // tratar erro
    }
    notifyListeners();
  }
}
