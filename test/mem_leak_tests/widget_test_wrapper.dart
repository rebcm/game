import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WidgetTestWrapper extends StatelessWidget {
  final Widget child;

  const WidgetTestWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}

void testWidgetWrapper(WidgetTester tester, Widget widget, Function() testFunction) async {
  await tester.pumpWidget(WidgetTestWrapper(child: widget));
  testFunction();
}
