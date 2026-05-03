import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart';
import 'package:rebcm/theme/app_theme.dart';
import './utils/screen_config.dart';

void main() {
  group('Visualization Edge Cases', () {
    testWidgets('renders correctly on different screen sizes', (tester) async {
      for (var size in ScreenConfig.getScreenSizes()) {
        await tester.binding.setSurfaceSize(size);
        await tester.pumpWidget(MyApp(themeMode: ThemeMode.light));
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MyApp),
          matchesGoldenFile('visualization_light_${size.width}x${size.height}.png'),
        );
        await tester.pumpWidget(MyApp(themeMode: ThemeMode.dark));
        await tester.pumpAndSettle();
        await expectLater(
          find.byType(MyApp),
          matchesGoldenFile('visualization_dark_${size.width}x${size.height}.png'),
        );
      }
    });
  });
}
