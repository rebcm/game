import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/main.dart'; // Assuming the widget to test is in main.dart

void main() {
  testWidgets('AnimationController is disposed', (tester) async {
    await tester.pumpWidget(MyApp()); // Wrap your widget in a test-compatible widget tree

    final animationControllerFinder = find.byType(AnimationController);
    expect(animationControllerFinder, findsOneWidget);

    final widget = tester.widget(animationControllerFinder) as AnimationController;
    expect(widget.isDisposed, false);

    await tester.pumpWidget(Container()); // Remove the widget from the tree

    expect(widget.isDisposed, true);
  });
}
