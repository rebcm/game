import 'package:flutter/material.dart';

class TipModal extends StatelessWidget {
  final String tip;

  const TipModal({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Dica', style: Theme.of(context).textTheme.titleLarge),
            Text(tip),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendi'),
            ),
          ],
        ),
      ),
    );
  }
}
