import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CloudflarePagesDeploy {
  static Future<void> deploy() async {
    final apiToken = dotenv.env['CLOUDFLARE_API_TOKEN'];
    final accountId = dotenv.env['CLOUDFLARE_ACCOUNT_ID'];

    if (apiToken == null || accountId == null) {
      throw Exception('CLOUDFLARE_API_TOKEN or CLOUDFLARE_ACCOUNT_ID is missing');
    }

    // Implement the deploy logic using the Wrangler API or CLI
    // For now, just print the variables
    print('CLOUDFLARE_API_TOKEN: $apiToken');
    print('CLOUDFLARE_ACCOUNT_ID: $accountId');
  }
}
