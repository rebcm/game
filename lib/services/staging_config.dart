import 'package:http/http.dart' as http;

class StagingConfig {
  static const String stagingBucketName = 'rebcm-staging';
  static const String cloudflareR2Endpoint = 'https://<your-cloudflare-r2-endpoint>';

  Future<void> configureStagingEnvironment() async {
    final response = await http.get(Uri.parse('$cloudflareR2Endpoint/$stagingBucketName'));

    if (response.statusCode == 200) {
      print('Staging environment configured successfully');
    } else {
      print('Failed to configure staging environment');
    }
  }
}
