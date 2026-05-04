import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Lint Error Test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            child: Text('This test will fail due to lint error'),
          ),
        ),
      ),
    );
    var a = 1;
    var b = 2;
    print(a + b); // This line is not the lint error we're introducing
    // Introducing a lint error by using an unused variable
    var unusedVariable = 10;
  });
}
