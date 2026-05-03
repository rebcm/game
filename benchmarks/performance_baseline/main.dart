import 'package:flutter/material.dart';
import 'package:game/main.dart' as game_main;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FPS Benchmark', (tester) async {
    await tester.pumpWidget(game_main.MyApp());
    await tester.pumpAndSettle();

    final binding = tester.binding;
    final fps = binding.frameMetrics.last.framesPerSecond;

    print('FPS: $fps');
    expect(fps, greaterThanOrEqualTo(60));
  });
}
