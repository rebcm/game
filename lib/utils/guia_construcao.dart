import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class GuiaConstrucao {
  static String material(BuildContext context) {
    return FlutterI18n.translate(context, 'guia_construcao_material');
  }

  static String tempoConstrucao(BuildContext context) {
    return FlutterI18n.translate(context, 'guia_construcao_tempo');
  }

  static String dificuldade(BuildContext context) {
    return FlutterI18n.translate(context, 'guia_construcao_dificuldade');
  }
}
