import 'package:http/http.dart' as http;
import 'dart:convert';

class SalvamentoRepository {
  Future<void> carregarMundo() async {
    final response = await http.get(Uri.parse('https://.example.com/mundo'));
    if (response.statusCode == 200) {
      final mundo = jsonDecode(response.body);
      // Salvar mundo no banco de dados
    } else {
      throw Exception('Erro ao carregar mundo');
    }
  }
}
