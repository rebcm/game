import 'package:flutter_test/flutter_test.dart';
import 'package:game/models/content/content.dart';

void main() {
  test('Content model', () {
    final content = Content('Test content');
    expect(content.data, 'Test content');
  });
}
