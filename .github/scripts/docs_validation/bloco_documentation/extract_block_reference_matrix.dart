import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game/bloco/bloco.dart';

void main() {
  final List<Bloco> blocos = Bloco.values.toList();
  final Map<String, dynamic> blocoMetadata = {};

  for (var bloco in blocos) {
    blocoMetadata[bloco.name] = {
      'id': bloco.id,
      'nome': bloco.nome,
      'descricao': bloco.descricao,
    };
  }

  final jsonData = jsonEncode(blocoMetadata);
  print(jsonData);
}
