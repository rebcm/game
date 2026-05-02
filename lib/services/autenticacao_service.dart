import 'package:http/http.dart' as http;

class AutenticacaoService {
  Future<bool> validarIdentidadeUsuario(String usuarioId) async {
    final response = await http.get(Uri.parse('https://construcao-criativa.workers.dev/api/usuarios/$usuarioId'));
    return response.statusCode == 200;
  }

  Future<int> obterLimiteMundos(String usuarioId) async {
    final response = await http.get(Uri.parse('https://construcao-criativa.workers.dev/api/usuarios/$usuarioId/limite-mundos'));
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Falha ao obter limite de mundos');
    }
  }
}
