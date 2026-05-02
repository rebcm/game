import 'package:http/http.dart' as http;

class CloudflareApiTokenHelper {
  Future<String> createApiToken() async {
    // Implement API Token creation logic here
    final response = await http.post(
      Uri.parse('https://api.cloudflare.com/client/v4/user/tokens'),
      headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json',
      },
      body: '{"name":"New Token","policies":[{"effect":"allow","resources":{"com.cloudflare.api.account.zone.*":"*"},"actions":{"zone:read":"*"}}]}',
    );
    return response.body;
  }
}
