import 'package:flutter/material.dart';

class TeclasControle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('WASD para mover'),
          Text('Espaço para ação'),
          Text('E para ação secundária'),
        ],
      ),
    );
  }
}
