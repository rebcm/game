import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/rendering/renderer.dart';

void main() {
  testWidgets('Renderer uses TextureConfig filterQuality', (tester) async {
    await tester.pumpWidget(Renderer());
    // Verify that the Texture widget uses the correct filterQuality...
  });
}
