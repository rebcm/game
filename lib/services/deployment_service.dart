import 'package:http/http.dart' as http;

class DeploymentService {
  Future<void> deployToCloudflare() async {
    final response = await http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/accounts/${const String.fromEnvironment('CLOUDFLARE_ACCOUNT_ID')}/pages/projects/rebcm-game/deployments'),
      headers: {
        'Authorization': 'Bearer ${const String.fromEnvironment('CLOUDFLARE_API_TOKEN')}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to deploy to Cloudflare');
    }
  }
}
