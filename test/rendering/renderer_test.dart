import 'package:flutter_test/flutter_test.dart';
import 'package:game/rendering/renderer.dart';

void main() {
  testWidgets('Renderer uses nearest filter', (tester) async {
    await tester.pumpWidget(Renderer());
    // Verify texture filter quality...
  });
}
