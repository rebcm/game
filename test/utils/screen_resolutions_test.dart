import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/screen_resolutions.dart';

void main() {
  test('minimalResolutions list is not empty', () {
    expect(ScreenResolutions.minimalResolutions, isNotEmpty);
  });

  test('minimalResolutions list contains valid sizes', () {
    for (var size in ScreenResolutions.minimalResolutions) {
      expect(size.width, greaterThan(0));
      expect(size.height, greaterThan(0));
    }
  });
}
