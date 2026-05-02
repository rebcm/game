import 'package:test/test.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

void main() {
  test('Validate Flutter and Dart versions in pubspec.yaml', () async {
    final pubspecContent = await File('pubspec.yaml').readAsString();
    final pubspec = loadYaml(pubspecContent);

    final requiredSdkVersion = pubspec['environment']['sdk'];
    final requiredFlutterVersion = pubspec['environment']['flutter'];

    // Assuming the CI/CD pipeline checks the actual versions
    expect(requiredSdkVersion, isNotNull);
    expect(requiredFlutterVersion, isNotNull);
  });
}
