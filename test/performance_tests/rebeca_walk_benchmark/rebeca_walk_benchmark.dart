import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart' as app;
import 'package:game/widgets/rebeca_walk/lottie_rebeca_walk.dart';
import 'package:game/widgets/rebeca_walk/rive_rebeca_walk.dart';
import 'package:game/widgets/rebeca_walk/procedural_rebeca_walk.dart';

void main() {
  testWidgets('Rebeca Walk Benchmark', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Expanded(child: LottieRebecaWalk()),
              Expanded(child: RiveRebecaWalk()),
              Expanded(child: ProceduralRebecaWalk()),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Benchmarking logic will be implemented here
  });
}
