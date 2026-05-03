import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';

void main() {
  testWidgets('FocusNode is disposed and not leaked', (tester) async {
    await LeakTracker.startTracking();
    final focusNode = FocusNode();
    await tester.pumpWidget(MyWidget(focusNode: focusNode));
    await tester.pumpAndSettle();
    focusNode.dispose();
    await tester.pumpAndSettle();
    final leaks = await LeakTracker.getLeaks();
    expect(leaks, isEmpty);
  });
}

class MyWidget extends StatefulWidget {
  final FocusNode focusNode;

  const MyWidget({Key? key, required this.focusNode}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TextField(
          focusNode: widget.focusNode,
          autofocus: true,
        ),
      ),
    );
  }
}
