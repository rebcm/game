import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/blocos/bloc.dart';
import 'dart:io';

void main() {
  test('All BLoC classes have corresponding documentation files', () {
    final blocClasses = Directory('lib/blocos').listSync().where((entity) => entity.path.endsWith('.dart'));
    for (var file in blocClasses) {
      final className = file.path.split('/').last.replaceAll('.dart', '');
      final docFile = File('docs/blocos/$className.md');
      expect(docFile.existsSync(), true, reason: 'Missing documentation for $className');
    }
  });
}
