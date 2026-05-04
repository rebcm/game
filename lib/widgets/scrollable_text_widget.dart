import 'package:flutter/material.dart';

class ScrollableTextWidget extends StatelessWidget {
  final String text;

  const ScrollableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(text),
    );
  }
}
