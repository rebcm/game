import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rebcm_game/bloco/bloco.dart';

Future<void> main() async {
  final blocoClasses = await _loadBlocoClasses();
  final blocoMetadata = _extractBlocoMetadata(blocoClasses);
  final jsonData = jsonEncode(blocoMetadata);
  print(jsonData);
}

Future<List<Type>> _loadBlocoClasses() async {
  final blocoClasses = <Type>[];
  final blocoClassesString = await rootBundle.loadString('assets/bloco_classes.txt');
  for (var line in blocoClassesString.split('\n')) {
    final type = await _getType(line.trim());
    if (type != null) {
      blocoClasses.add(type);
    }
  }
  return blocoClasses;
}

Future<Type?> _getType(String className) async {
  try {
    return await rootBundle.loadString('package:rebcm_game/$className.dart').then((value) => reflectType(className));
  } catch (_) {
    return null;
  }
}

List<Map<String, dynamic>> _extractBlocoMetadata(List<Type> blocoClasses) {
  final blocoMetadata = <Map<String, dynamic>>[];
  for (var blocoClass in blocoClasses) {
    final instance = BlocoFactory.createBloco(blocoClass);
    if (instance != null) {
      blocoMetadata.add({
        'nome': instance.nome,
        'descricao': instance.descricao,
        'categoria': instance.categoria,
      });
    }
  }
  return blocoMetadata;
}
