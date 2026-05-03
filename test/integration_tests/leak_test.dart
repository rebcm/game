import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
import 'package:game/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo is garbage collected', (tester) async {
    await tester.pumpWidget(MyApp());
    final estadoJogo = EstadoJogo();
    await tester.pumpAndSettle();

    expect(
      await memoryLeakCheck(
        () async {
          estadoJogo.dispose();
          await tester.pumpAndSettle();
        },
        EstadoJogo,
      ),
      isTrue,
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EstadoJogo(),
    );
  }
}
