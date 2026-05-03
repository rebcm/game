import 'package:http/http.dart' as http;

class DicasService {
  Future<bool> verificarAprovacaoTecnica() async {
    final response = await http.get(Uri.parse('https://example.com/dicas_aprovadas.txt'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
