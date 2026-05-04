import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_i18n/flutter_i18n.dart';

class TipService {
  Future<String> loadTip(String tipName) async {
    final tipContent = await rootBundle.loadString('assets/tips/\$tipName.md');
    return tipContent;
  }

  Future<List<String>> listTips() async {
    // Implementar lógica para listar dicas disponíveis
    return [];
  }
}
