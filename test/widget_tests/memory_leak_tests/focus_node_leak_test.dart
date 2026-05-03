import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker/leak_tracker.dart';

void main() {
  testWidgets('FocusNode is disposed and not leaked', (tester) async {
    await LeakTracker.startTracking();
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();
    await LeakTracker.stopTracking();
    final leaks = await LeakTracker.getLeaks();
    expect(leaks, isEmpty);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Focus(
          focusNode: _focusNode,
          child: Container(),
        ),
      ),
    );
  }
}
