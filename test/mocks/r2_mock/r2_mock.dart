import 'package:http/http.dart' as http;
import 'dart:convert';

class R2Mock {
  final http.Client _client;
  final String _bucketName;

  R2Mock(this._client, this._bucketName);

  Future<String> putObject(String objectName, List<int> data) async {
    return 'mocked-object-url';
  }

  Future<List<int>> getObject(String objectName) async {
    return utf8.encode('mocked-object-content');
  }

  Future<void> deleteObject(String objectName) async {
    return;
  }

  Future<List<String>> listObjects() async {
    return ['mocked-object-1', 'mocked-object-2'];
  }
}
