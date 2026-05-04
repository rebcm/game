import 'package:flutter/material.dart';

class TipsDisplay extends StatelessWidget {
  final String tip;

  const TipsDisplay({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          tip,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
