import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game/bloco/bloco.dart';

void main() {
  final List<Bloco> blocos = Bloco.values.toList();
  final Map<String, dynamic> blocoMap = {};

  for (var bloco in blocos) {
    blocoMap[bloco.name] = {
      'id': bloco.id,
      'nome': bloco.nome,
      'descricao': bloco.descricao,
    };
  }

  final jsonString = JsonEncoder.withIndent('  ').convert(blocoMap);
  print(jsonString);

  // Save to file
  final outputFile = File('./.github/scripts/docs_validation/bloco_documentation/output.json');
  outputFile.writeAsStringSync(jsonString);
}
