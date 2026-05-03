import 'package:http/http.dart' as http;
import 'dart:convert';

class DicasService {
  Future<List<Dica>> getDicas() async {
    final response = await http.get(Uri.parse('assets/dicas/dicas.json'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['dicas'].map((json) => Dica.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar dicas');
    }
  }
}

class Dica {
  final int id;
  final String conteudo;

  Dica({required this.id, required this.conteudo});

  factory Dica.fromJson(Map<String, dynamic> json) {
    return Dica(id: json['id'], conteudo: json['conteudo']);
  }
}
