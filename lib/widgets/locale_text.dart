import 'package:flutter/material.dart';

class LocaleText extends StatelessWidget {
  final String key;

  LocaleText(this.key);

  @override
  Widget build(BuildContext context) {
    return Text(key);
  }
}
