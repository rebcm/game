import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/arm_texture.dart';

void main() {
  group('ArmTextureMappingTest', () {
    testWidgets('should map classic arm texture correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ArmTexture(
            armType: ArmType.classic,
            texture: Image.asset('assets/texture.png'),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isNotNull);
    });

    testWidgets('should map slim arm texture correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ArmTexture(
            armType: ArmType.slim,
            texture: Image.asset('assets/texture.png'),
          ),
        ),
      );

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isNotNull);
    });

    testWidgets('should throw error for invalid arm type', (tester) async {
      expect(
        () => ArmTexture(
          armType: null,
          texture: Image.asset('assets/texture.png'),
        ),
        throwsAssertionError,
      );
    });
  });
}
