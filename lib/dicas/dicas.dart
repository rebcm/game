import 'package:flutter/material.dart';

class Dicas extends StatelessWidget {
  final String dica;

  const Dicas({Key? key, required this.dica}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      dica,
      maxLines: null,
      overflow: TextOverflow.visible,
      softWrap: true,
      style: TextStyle(fontSize: 16),
    );
  }
}
