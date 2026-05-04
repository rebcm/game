import 'package:flutter/material.dart';
import 'package:game/widgets/text_overflow_handler/text_overflow_handler.dart';

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Screen'),
      ),
      body: Row(
        children: [
          TextOverflowHandler(text: 'This is a very long text that should be handled properly'),
        ],
      ),
    );
  }
}
