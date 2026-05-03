import 'package:http/http.dart' as http;

class DicasService {
  Future<bool> verificarAprovacao() async {
    final response = await http.get(Uri.parse('https://example.com/dicas.txt'));
    if (response.statusCode == 200) {
      return response.body.contains('approved_by_game_designer=true');
    } else {
      throw Exception('Falha ao verificar aprovação');
    }
  }
}
