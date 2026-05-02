import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SalvamentoService {
  final String _cloudflareUrl = 'https://your-cloudflare-url.com';
  final String _apiKey = 'your-api-key';

  Future<void> salvarMundo(String mundo) async {
    final response = await http.post(
      Uri.parse(_cloudflareUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({'mundo': mundo}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('mundo_salvo', mundo);
    } else {
      throw Exception('Erro ao salvar mundo');
    }
  }

  Future<String> carregarMundo() async {
    final prefs = await SharedPreferences.getInstance();
    final mundoSALvo = prefs.getString('mundo_salvo');

    if (mundoSALvo != null) {
      return mundoSALvo;
    } else {
      final response = await http.get(
        Uri.parse(_cloudflareUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['mundo'];
      } else {
        throw Exception('Erro ao carregar mundo');
      }
    }
  }
}
