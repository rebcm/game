import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('README.md contains required headers', () async {
    final readmeContent = await File('README.md').readAsString();
    expect(readmeContent, contains('# Rebeca Game'));
    expect(readmeContent, contains('## Features'));
    expect(readmeContent, contains('## Installation'));
  });
}
