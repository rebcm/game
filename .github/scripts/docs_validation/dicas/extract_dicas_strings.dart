import 'package:flutter/material.dart';
import 'package:rebcm/game.dart';

void main() {
  final dicas = Dicas();
  final strings = dicas.getAllDicasStrings();
  print(strings.join('\n'));
}
