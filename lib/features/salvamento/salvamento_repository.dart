import Intl.message('package:http/http.dart') as http;
import Intl.message('dart:convert');

class SalvamentoRepository {
  Future<void> carregarMundo() async {
    final response = await http.get(Uri.parse(Intl.message('https://.example.com/mundo')));
    if (response.statusCode == 200) {
      final mundo = jsonDecode(response.body);
      // Salvar mundo no banco de dados
    } else {
      throw Exception(Intl.message('Erro ao carregar mundo'));
    }
  }
}
