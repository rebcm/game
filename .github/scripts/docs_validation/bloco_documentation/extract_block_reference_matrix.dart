import 'dart:convert';
import 'package:game/blocos/bloco.dart';
import 'package:game/blocos/blocos.dart';

void main() {
  final Map<String, dynamic> blockMetadata = {};

  for (var block in Blocos().getAllBlocks()) {
    blockMetadata[block.id] = {
      'id': block.id,
      'nome': block.nome,
      'descricao': block.descricao,
      'tipo': block.tipo.toString(),
      'propriedades': block.propriedades.map((p) => p.toString()).toList(),
    };
  }

  final jsonString = JsonEncoder.withIndent('  ').convert(blockMetadata);
  print(jsonString);
}
