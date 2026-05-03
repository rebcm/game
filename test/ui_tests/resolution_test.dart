import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/utils/resolution_matrix.dart';

void main() {
  group('UI Resolution Test', () {
    for (var resolution in ResolutionMatrix.supportedResolutions) {
      testWidgets('renders correctly at ${resolution.width}x${resolution.height}', (tester) async {
        await tester.binding.setSurfaceSize(resolution);
        await tester.pumpWidget(app.MyApp());
        await tester.pumpAndSettle();
        expect(find.byType(app.MyApp), findsOneWidget);
      });
    }
  });
}
