import 'dart:io';
import 'package:game/docs/estruturas_sugeridas.dart';

void main() {
  final estruturasSugeridas = EstruturasSugeridas.estruturas;
  final output = estruturasSugeridas.map((estrutura) => estrutura.nome).join('\n');
  File('lib/docs/estruturas_sugeridas.txt').writeAsStringSync(output);
}
