import 'package:http/http.dart' as http;

class ArtefatoService {
  Future<bool> verificarIntegridadeArtefato() async {
    try {
      final response = await http.get(Uri.parse('https://example.com/artefato'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> simularFalhaConexaoServidor() async {
    try {
      final response = await http.get(Uri.parse('https://example.com/artefato-falha'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
