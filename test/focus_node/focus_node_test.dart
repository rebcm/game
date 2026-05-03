import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FocusNode is disposed correctly', (tester) async {
    await tester.pumpWidget(MyWidget());
    await tester.pumpAndSettle();

    final focusNode = FocusNode();
    final widget = MyTestWidget(focusNode: focusNode);

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(focusNode.hasFocus, isFalse);

    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();

    expect(() => focusNode.hasFocus, throwsFlutterError);
  });
}

class MyTestWidget extends StatefulWidget {
  final FocusNode focusNode;

  MyTestWidget({required this.focusNode});

  @override
  _MyTestWidgetState createState() => _MyTestWidgetState();
}

class _MyTestWidgetState extends State<MyTestWidget> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.requestFocus();
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      child: Container(),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}
