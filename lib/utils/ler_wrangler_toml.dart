import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:toml/toml.dart';

class WranglerToml {
  static Future<Map<String, dynamic>> lerWranglerToml() async {
    final tomlString = await rootBundle.loadString('wrangler.toml');
    final tomlDoc = TomlDocument.parse(tomlString);
    return tomlDoc.toJson();
  }
}
