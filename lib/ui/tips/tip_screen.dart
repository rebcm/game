import 'package:flutter/material.dart';

class TipScreen extends StatelessWidget {
  final String tip;

  const TipScreen({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(tip),
      ),
    );
  }
}
