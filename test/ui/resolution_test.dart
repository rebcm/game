import 'package:flutter_test/flutter_test.dart';
import 'package:game/utils/resolution_constants.dart';

void main() {
  testWidgets('Test UI overflow on supported resolutions', (tester) async {
    for (var resolution in ResolutionConstants.supportedResolutions) {
      await tester.binding.setSurfaceSize(Size(resolution, resolution * 1.77));
      await tester.pumpWidget(MyApp()); // Assuming MyApp is the main widget
      await tester.pumpAndSettle();
      expect(find.byType(OverflowError), findsNothing);
    }
  });
}
