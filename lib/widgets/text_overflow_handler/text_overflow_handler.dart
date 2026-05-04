import 'package:flutter/material.dart';

class TextOverflowHandler extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TextOverflowHandler({Key? key, required this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
