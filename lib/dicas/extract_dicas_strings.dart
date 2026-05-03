import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  final dicasJson = await rootBundle.loadString('lib/dicas/dicas.json');
  final dicas = jsonDecode(dicasJson);

  // Lógica para extrair as dicas
  print(dicas);
}
