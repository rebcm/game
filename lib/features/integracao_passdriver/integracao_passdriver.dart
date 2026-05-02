import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

class IntegracaoPassdriver with ChangeNotifier {
  final InterceptedClient _client = InterceptedClient(
    interceptors: [
      // Adicione interceptadores aqui
    ],
    requestTimeout: Duration(seconds: 10),
  );

  Future<void> realizarRequisicao() async {
    try {
      final response = await _client.get(Uri.parse('https://api.passdriver.com.br/exemplo'));
      if (response.statusCode == 200) {
        // Processar resposta
      } else {
        // Tratar erro
      }
    } catch (e) {
      // Tratar exceção
    }
  }
}
