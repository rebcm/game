import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class DicasService {
  Future<void> validarAprovacaoTecnica() async {
    final conteudo = await rootBundle.loadString('assets/dicas/dicas.json');
    final jsonData = jsonDecode(conteudo);
    if (jsonData['aprovado'] != true) {
      throw Exception('Dicas não aprovadas tecnicamente.');
    }
  }

  Future<void> carregarDicas() async {
    await validarAprovacaoTecnica();
    // Carregar dicas após validação
  }
}
