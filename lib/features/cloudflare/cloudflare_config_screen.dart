import 'package:flutter/material.dart';
import 'package:passdriver/features/cloudflare/cloudflare_config.dart';
import 'package:provider/provider.dart';

class CloudflareConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CloudflareConfig()..loadEnv(),
      child: Consumer<CloudflareConfig>(
        builder: (context, config, child) {
          if (!config.isConfigured) {
            return Text('Erro: Variáveis de ambiente do Cloudflare não configuradas');
          }
          return Text('Cloudflare configurado corretamente');
        },
      ),
    );
  }
}
