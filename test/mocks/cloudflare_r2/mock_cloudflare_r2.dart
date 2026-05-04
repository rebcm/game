import 'package:http/http.dart' as http;
import 'package:game/services/cloudflare_r2/cloudflare_r2.dart';

class MockCloudflareR2 implements CloudflareR2 {
  @override
  Future<http.Response> putObject(String bucket, String objectName, List<int> data) async {
    return http.Response('', 200);
  }

  @override
  Future<http.Response> getObject(String bucket, String objectName) async {
    return http.Response('test data', 200);
  }

  @override
  Future<http.Response> deleteObject(String bucket, String objectName) async {
    return http.Response('', 204);
  }
}
