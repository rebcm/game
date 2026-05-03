import 'package:flutter/material.dart';

class TipModal extends StatelessWidget {
  final String tip;

  const TipModal({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dica'),
      content: Text(tip),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
