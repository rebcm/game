import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizeTextWrapper extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;

  const AutoSizeTextWrapper({
    Key? key,
    required this.text,
    this.style,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
