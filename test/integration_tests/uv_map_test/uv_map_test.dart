import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:game/main.dart' as app;

void main() {
  testGoldens('UV Map Test', (tester) async {
    await tester.pumpWidgetBuilder(app.MyApp());
    await tester.pumpAndSettle();
    await screenMatchesGolden(tester, 'uv_map_golden');
  });
}
