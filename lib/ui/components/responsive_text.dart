import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;

  const ResponsiveText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
      overflow: TextOverflow.visible,
    );
  }
}
