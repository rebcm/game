import 'package:http/http.dart' as http;

class DeploymentService {
  Future<void> deployToCloudflare(String apiToken, String accountId) async {
    final response = await http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/$accountId/pages/projects/rebcm-game/publish'),
      headers: {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json',
      },
      body: '{"branch":"main"}',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to deploy to Cloudflare');
    }
  }
}
