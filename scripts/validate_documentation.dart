import 'package:yaml/yaml.dart';
import 'dart:io';

void main() {
  final pubspecContent = File('pubspec.yaml').readAsStringSync();
  final pubspecYaml = loadYaml(pubspecContent);

  final dependencies = pubspecYaml['dependencies'];
  final devDependencies = pubspecYaml['dev_dependencies'];

  final documentationFile = File('.github/docs/dependencies/pubspec_dependencies.md');
  final documentationContent = documentationFile.readAsStringSync();

  final regex = RegExp(r'dependencies:\n((?:.*\n)*)\ndev_dependencies:', multiLine: true);
  final match = regex.firstMatch(documentationContent);

  if (match != null) {
    final documentedDependencies = match.group(1);
    final actualDependencies = _formatDependencies(dependencies);
    final actualDevDependencies = _formatDependencies(devDependencies);

    if (documentedDependencies?.trim() != actualDependencies.trim()) {
      print('Dependencies in documentation do not match actual dependencies.');
      exit(1);
    }

    final devDependenciesRegex = RegExp(r'dev_dependencies:\n((?:.*\n)*)', multiLine: true);
    final devDependenciesMatch = devDependenciesRegex.firstMatch(documentationContent);

    if (devDependenciesMatch != null) {
      final documentedDevDependencies = devDependenciesMatch.group(1);
      if (documentedDevDependencies?.trim() != actualDevDependencies.trim()) {
        print('Dev dependencies in documentation do not match actual dev dependencies.');
        exit(1);
      }
    }
  } else {
    print('Could not find dependencies section in documentation.');
    exit(1);
  }
}

String _formatDependencies(Map<dynamic, dynamic> dependencies) {
  final buffer = StringBuffer();
  dependencies.forEach((key, value) {
    buffer.write('  $key: $value\n');
  });
  return buffer.toString();
}
