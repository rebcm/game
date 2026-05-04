import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'rive_implementation/rebeca_walk_rive.dart';
import 'lottie_implementation/rebeca_walk_lottie.dart';
import 'procedural_implementation/rebeca_walk_procedural.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Rebeca Walk Benchmark', () {
    testWidgets('Rive Implementation', (tester) async {
      await tester.pumpWidget(RebecaWalkRive());
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('Lottie Implementation', (tester) async {
      await tester.pumpWidget(RebecaWalkLottie());
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5));
    });

    testWidgets('Procedural Implementation', (tester) async {
      await tester.pumpWidget(RebecaWalkProcedural());
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5));
    });
  });
}
