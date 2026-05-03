import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('estado_jogo is garbage collected', (tester) async {
    await tester.pumpWidget(MyApp());
    final estadoJogo = EstadoJogo();
    await tester.pumpAndSettle();
    expect(estadoJogo, isNotNull);
    LeakChecker.checkLeaks();
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
