import 'package:flutter/material.dart';

class Dicas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Dica: Construa algo incrível!',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
