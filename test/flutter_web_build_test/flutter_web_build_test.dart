import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main() {
  test('Flutter Web build output validation', () async {
    final buildDir = Directory('build/web');
    expect(buildDir.existsSync(), isTrue);

    final assetsDir = Directory('build/web/assets');
    expect(assetsDir.existsSync(), isTrue);

    final indexHtml = File('build/web/index.html');
    expect(indexHtml.existsSync(), isTrue);
  });
}
