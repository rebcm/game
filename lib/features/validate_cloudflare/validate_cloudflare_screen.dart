import 'package:flutter/material.dart';

class ValidateCloudflareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validar Cloudflare'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final response = await http.get(Uri.parse('/validate-cloudflare'));
            if (response.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CLOUDFLARE_API_TOKEN e CLOUDFLARE_ACCOUNT_ID configurados corretamente')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: ${response.body}')));
            }
          },
          child: Text('Validar'),
        ),
      ),
    );
  }
}
