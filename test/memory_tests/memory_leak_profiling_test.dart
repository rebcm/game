import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/game.dart';

void main() {
  testWidgets('Memory Leak Profiling Test', (tester) async {
    await tester.pumpWidget(MyApp());
    // Implement memory leak profiling test logic here
  });
}
