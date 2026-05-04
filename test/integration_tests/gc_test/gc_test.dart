import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GC Test', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    // Force GC
    await tester.binding.debugForceGC();
    await tester.pumpAndSettle();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('GC Test'),
        ),
      ),
    );
  }
}
