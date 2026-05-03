import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FocusNode is properly disposed', (tester) async {
    await tester.pumpWidget(MyWidget());
    await tester.pumpAndSettle();

    final focusNode = tester.state<MyWidgetState>(find.byType(MyWidget)).focusNode;

    expect(focusNode.hasFocus, isFalse);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(focusNode.hasFocus, isTrue);

    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();

    expect(() => focusNode.hasFocus, throwsFlutterError);
  });
}

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            focusNode: focusNode,
            onPressed: () {},
            child: Text('Button'),
          ),
        ),
      ),
    );
  }
}
