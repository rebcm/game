import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/ui/configuracoes/volume_control.dart';

void main() {
  testWidgets('VolumeControl widget test', (tester) async {
    await tester.pumpWidget(MaterialApp(home: VolumeControl()));
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
  });
}
