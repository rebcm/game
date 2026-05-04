import 'package:flutter_test/flutter_test.dart';
import 'package:game/rendering/texture_config.dart';

void main() {
  test('Texture filter is nearest', () {
    expect(TextureConfig.filter, TextureFilter.nearest);
  });
}
