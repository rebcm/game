import 'package:flutter/material.dart';

class TipTextWrapper extends StatelessWidget {
  final String tipText;

  const TipTextWrapper({Key? key, required this.tipText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      tipText,
      softWrap: true, // Enable text wrapping
      overflow: TextOverflow.visible, // Ensure text doesn't overflow
    );
  }
}
