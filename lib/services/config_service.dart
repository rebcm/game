import 'package:flutter/services.dart' show rootBundle;
import 'package:toml/toml.dart';

class ConfigService {
  late Map<String, dynamic> _config;

  Future<void> loadConfig() async {
    final tomlString = await rootBundle.loadString('wrangler.toml');
    _config = TomlDocument.parse(tomlString).toMap();
  }

  String get stringVariable => _config['string_variable'];
  bool get booleanVariable => _config['boolean_variable'];
  num get numberVariable => _config['number_variable'];
}
