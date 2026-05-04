import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/settings/settings_screen.dart';

void main() {
  testWidgets('SettingsScreen has title', (tester) async {
    await tester.pumpWidget(MaterialApp(home: SettingsScreen()));
    expect(find.text('Settings'), findsOneWidget);
  });
}
