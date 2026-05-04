import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Heap dump test', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Heap dump test'),
        ),
      ),
    );
  }
}
