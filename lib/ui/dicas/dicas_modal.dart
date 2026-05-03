import 'package:flutter/material.dart';

class DicasModal extends StatelessWidget {
  const DicasModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Dicas', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Text('Aqui vão as dicas para o usuário.', style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}
