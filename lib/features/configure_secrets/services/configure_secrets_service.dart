import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigureSecretsService {
  Future<void> configureSecrets(String cloudflareApiToken, String cloudflareAccountId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('CLOUDFLARE_API_TOKEN', cloudflareApiToken);
    await prefs.setString('CLOUDFLARE_ACCOUNT_ID', cloudflareAccountId);
  }}
}
