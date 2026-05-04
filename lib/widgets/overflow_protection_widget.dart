import 'package:flutter/material.dart';

class OverflowProtectionWidget extends StatelessWidget {
  final String text;

  const OverflowProtectionWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
