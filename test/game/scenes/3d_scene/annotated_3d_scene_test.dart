import 'package:flutter_test/flutter_test.dart';
import 'package:game/scenes/3d_scene/annotated_3d_scene.dart';

void main() {
  testWidgets('logs rebuild and render frame', (tester) async {
    await tester.pumpWidget(Annotated3DScene());
    // Test logs
  });
}
