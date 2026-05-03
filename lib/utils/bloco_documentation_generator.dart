import 'dart:convert';
import 'package:game/utils/bloco_registry.dart';

class BlocoDocumentationGenerator {
  static String generate() {
    final blocos = BlocoRegistry.getBlocos();
    final jsonData = jsonEncode({'blocos': blocos});
    return jsonData;
  }
}
