import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/dicas/dicas_wrapper.dart';

void main() {
  testWidgets('DicasWrapper build', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DicasWrapper(
          child: Container(),
        ),
      ),
    );

    expect(find.byType(Container), findsOneWidget);
  });
}
