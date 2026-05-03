import 'package:flutter/material.dart';

class DicasScreen extends StatelessWidget {
  const DicasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas'),
      ),
      body: ListView.builder(
        itemCount: dicas.length, // Replace with actual number of dicas
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Dica ${index + 1}'), // Replace with actual dica title
            subtitle: Text('Descrição da dica ${index + 1}'), // Replace with actual dica description
          );
        },
      ),
    );
  }
}
import 'package:game/data/dicas/dicas_data.dart';
