import 'package:http/http.dart' as http;
import 'package:game/mocks/r2_mock/r2_mock.dart';

class R2Service {
  final http.Client _client;
  final String _bucketName;
  late final R2Mock _r2Mock;

  R2Service(this._client, this._bucketName) {
    _r2Mock = R2Mock(_client, _bucketName);
  }

  Future<String> putObject(String objectName, List<int> data) async {
    return _r2Mock.putObject(objectName, data);
  }

  Future<List<int>> getObject(String objectName) async {
    return _r2Mock.getObject(objectName);
  }

  Future<void> deleteObject(String objectName) async {
    return _r2Mock.deleteObject(objectName);
  }

  Future<List<String>> listObjects() async {
    return _r2Mock.listObjects();
  }
}
