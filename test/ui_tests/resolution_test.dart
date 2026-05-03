import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/utils/screen_resolutions.dart';

void main() {
  group('UI Resolution Tests', () {
    for (var resolution in ScreenResolutions.minimalResolutions) {
      testWidgets('renders correctly on ${resolution.width}x${resolution.height}', (tester) async {
        await tester.binding.setSurfaceSize(resolution);
        await tester.pumpWidget(app.MyApp());
        await tester.pumpAndSettle();
        expect(find.byType(app.MyHomePage), findsOneWidget);
      });
    }
  });
}
