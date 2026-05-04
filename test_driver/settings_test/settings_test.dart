import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/settings/models/audio_settings.dart';
import 'package:game/features/settings/settings_screen.dart';
import 'package:game/features/settings/widgets/audio_settings_widget.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Audio settings widget test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AudioSettings()),
        ],
        child: MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    expect(find.text('Música'), findsOneWidget);
    expect(find.text('Efeitos Sonoros'), findsOneWidget);
    expect(find.byType(Switch), findsNWidgets(2));
    expect(find.byType(Slider), findsNWidgets(2));
  });
}
