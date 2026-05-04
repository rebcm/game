import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart';
import 'package:game/utils/screen_resolutions/screen_resolutions.dart';
void main() {
  testWidgets('UI test for different screen resolutions', (tester) async {
    for (var resolution in ScreenResolutions.resolutions) {
      await tester.binding.window.physicalSizeTestValue = Size(
        resolution['width']!.toDouble(),
        resolution['height']!.toDouble(),
      );
      await tester.pumpWidget(MyApp());
      expect(find.text('Rebeca\'s Creative Building'), findsOneWidget);
    }
  });
}
