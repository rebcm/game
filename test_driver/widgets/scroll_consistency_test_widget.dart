import 'package:flutter/material.dart';

class ScrollConsistencyTestWidget extends StatefulWidget {
  @override
  _ScrollConsistencyTestWidgetState createState() => _ScrollConsistencyTestWidgetState();
}

class _ScrollConsistencyTestWidgetState extends State<ScrollConsistencyTestWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key('scrollable'),
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(title: Text('test_item $index'));
      },
    );
  }
}
