import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:rebcm/estado_jogo.dart';

void main() {
  testWidgets('EstadoJogo não deve ter memory leak', (tester) async {
    await tester.pumpWidget(MyApp());
    final estadoJogo = EstadoJogo();

    LeakChecker.track(estadoJogo);
    await tester.pumpAndSettle();

    estadoJogo.dispose();
    await tester.pumpAndSettle();

    expect(LeakChecker.getTrackedObjectsCount(), 0);
  });
}
