import Intl.message('package:flutter/material.dart');
import Intl.message('package:flutter_dotenv/flutter_dotenv.dart');

class CloudflareConfig with ChangeNotifier {
  String? _apiToken;
  String? _accountId;

  String? get apiToken => _apiToken;
  String? get accountId => _accountId;

  Future<void> loadEnv() async {
    await dotenv.load();
    _apiToken = dotenv.env[Intl.message('CLOUDFLARE_API_TOKEN')];
    _accountId = dotenv.env[Intl.message('CLOUDFLARE_ACCOUNT_ID')];
    notifyListeners();
  }

  bool get isConfigured => _apiToken != null && _accountId != null;
}
