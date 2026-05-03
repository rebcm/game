import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dicas widget responsividade test', (tester) async {
    await tester.binding.setSurfaceSize(const Size(280, 600));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final dicasWidget = find.byType(DicasWidget);
    expect(dicasWidget, findsOneWidget);

    final dicasText = find.text('Dicas');
    expect(dicasText, findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(300, 600));
    await tester.pumpAndSettle();

    expect(dicasWidget, findsOneWidget);
    expect(dicasText, findsOneWidget);
  });
}
