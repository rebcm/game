import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/widgets/tips.dart';

void main() {
  testWidgets('Tips widget does not overflow on small screen', (tester) async {
    await tester.binding.window.physicalSizeTestValue = Size( smallestScreenWidth, smallestScreenHeight);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Tips(),
        ),
      ),
    );

    await expectLater(find.byType(Tips), matchesGoldenFile('tips_widget_golden.png'));
  });
}

const double smallestScreenWidth = 320;
const double smallestScreenHeight = 480;
