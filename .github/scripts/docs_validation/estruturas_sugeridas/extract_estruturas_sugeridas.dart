import 'package:flutter/material.dart';
import 'package:game/docs/estruturas_sugeridas.dart';

void main() {
  final estruturasSugeridas = EstruturasSugeridas();
  final extractedData = estruturasSugeridas.extractData();
  print(extractedData);
  // Write to file
  // ignore: avoid_print
  print('Writing to lib/docs/estruturas_sugeridas.txt');
}
