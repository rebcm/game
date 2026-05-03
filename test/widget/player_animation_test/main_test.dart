import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('player animation test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Container(),
      ),
    );
  });
}
