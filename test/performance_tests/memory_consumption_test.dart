import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/main.dart' as app;
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

void main() {
  testWidgets('Memory Consumption Test', (tester) async {
    await tester.pumpWidget(const app.RebecaApp());
    await tester.pumpAndSettle();

    // Implement memory consumption test logic here
    // For example, using FlutterDriver or other performance testing tools
  });
}
