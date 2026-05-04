import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test tip moments during gameplay', (tester) async {
    app.main();
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byKey(Key('start_game_button')));
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byKey(Key('build_mode_button')));
    await tester.pumpAndSettle(Duration(seconds: 1));

    await tester.tap(find.byKey(Key('block_type_switch')));
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text('Dica: Use o joystick para mover Rebeca'), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));

    await tester.drag(find.byKey(Key('joystick')), Offset(50, 0));
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text('Dica: Toque na tela para colocar blocos'), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));

    await tester.tap(find.byKey(Key('build_button')));
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text('Dica: Você pode remover blocos tocando neles novamente'), findsOneWidget);
  });
}
