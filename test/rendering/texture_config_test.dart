import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/rendering/texture_config.dart';

void main() {
  test('TextureConfig filterQuality is FilterQuality.none', () {
    expect(TextureConfig.filterQuality, FilterQuality.none);
  });

  test('TextureConfig textureFilter is TextureFilter.nearest', () {
    expect(TextureConfig.textureFilter, TextureFilter.nearest);
  });
}
