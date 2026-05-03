import 'dart:io';
import 'package:yaml/yaml.dart';

void main() {
  final file = File('pubspec.yaml');
  final pubspecContent = file.readAsStringSync();
  final pubspecYaml = loadYaml(pubspecContent);

  print(pubspecYaml);
  // Implement the logic to extract and list the specific game structures that need templates
}
