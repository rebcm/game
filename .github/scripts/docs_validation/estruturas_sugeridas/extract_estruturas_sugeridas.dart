import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game/docs/estruturas_sugeridas.dart';

void main() {
  final estruturasSugeridas = EstruturasSugeridas();
  final estruturas = estruturasSugeridas.estruturas;

  final jsonData = jsonEncode(estruturas);
  print(jsonData);
}
