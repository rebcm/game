import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game/bloco/bloco.dart';

void main() {
  final blocoList = Bloco.values.map((e) => e.toString()).toList();
  final blocoMap = {};

  for (var bloco in blocoList) {
    final blocoName = bloco.split('.').last;
    blocoMap[blocoName] = {
      'nome': blocoName,
      'descricao': 'Descricao do bloco $blocoName',
    };
  }

  final jsonData = jsonEncode(blocoMap);
  print(jsonData);

  // Save to file
  final file = File('docs/bloco_documentation.json');
  file.writeAsStringSync(jsonData);
}
