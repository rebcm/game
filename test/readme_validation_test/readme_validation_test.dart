import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('README contains required headers', () {
    final readmeContent = File('README.md').readAsStringSync();
    expect(readmeContent, contains('# Rebeca Creative Game'));
    expect(readmeContent, contains('## Features'));
    expect(readmeContent, contains('## Installation'));
  });
}
