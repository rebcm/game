import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();
    _checkCloudflareSecrets();
  }

  Future<void> _checkCloudflareSecrets() async {
    await dotenv.load();
    final cloudflareApiToken = dotenv.env['CLOUDFLARE_API_TOKEN'];
    final cloudflareAccountId = dotenv.env['CLOUDFLARE_ACCOUNT_ID'];
    if (cloudflareApiToken == null || cloudflareAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cloudflare secrets não estão configurados')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Center(child: Text('Configurações')),
    );
  }
}
