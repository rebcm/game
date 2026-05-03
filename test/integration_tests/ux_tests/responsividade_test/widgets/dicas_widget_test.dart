import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Dicas widget responsividade test', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 480));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Dicas'), findsOneWidget);
    expect(find.text('Construção'), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(200, 400));
    await tester.pumpAndSettle();

    expect(find.text('Dicas'), findsOneWidget);
    expect(find.text('Construção'), findsOneWidget);
  });
}
