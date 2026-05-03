import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo is garbage collected', (tester) async {
    await LeakTracker.startTracking();
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    await LeakTracker.stopTracking();
    expect(LeakTracker.getLeaks(), isEmpty);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EstadoJogo(),
      ),
    );
  }
}
