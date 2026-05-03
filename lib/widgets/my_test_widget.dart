import 'package:flutter/material.dart';

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
