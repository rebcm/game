import 'dart:io';
import 'package:dotenv/dotenv.dart';

void main() {
  final env = Dotenv.load(fileName: '.env');
  final wranglerToml = File('wrangler.toml').readAsStringSync();

  // Extract vars from wrangler.toml
  final vars = RegExp(r'\[vars\]\n(.*?)\n\n', dotAll: true)
      .firstMatch(wranglerToml)
      ?.group(1)
      ?.split('\n')
      .map((line) => line.split('=')[0].trim())
      .toList() ??
      [];

  for (var var in vars) {
    if (env[var] == null) {
      print('Variável $var não está definida no .env');
      exit(1);
    }
  }

  print('Todas as variáveis estão definidas corretamente.');
}
