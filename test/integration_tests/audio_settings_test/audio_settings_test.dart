import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/features/settings/settings_screen.dart';
import 'package:game/features/settings/providers/audio_settings_provider.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Audio settings test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AudioSettingsProvider()),
        ],
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Música'), findsOneWidget);
    expect(find.text('Efeitos Sonoros'), findsOneWidget);

    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch).last);
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Slider).first, Offset(0.5, 0));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Slider).last, Offset(0.5, 0));
    await tester.pumpAndSettle();
  });
}
