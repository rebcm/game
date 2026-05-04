import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;

void main() {
  testWidgets('Frame timing test', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final timeline = await tester.binding.getTimeline();
    final events = timeline.events.where((event) => event['name'] == 'Frame').toList();

    for (var event in events) {
      print('Frame timing: ${event['dur']}');
    }

    expect(events, isNotEmpty);
  });
}
