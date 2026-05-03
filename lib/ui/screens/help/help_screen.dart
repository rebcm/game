import 'package:flutter/material.dart';
import 'package:game/ui/widgets/tips/tip_modal.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Dica 1'),
            subtitle: Text('Descrição da dica 1'),
          ),
          ListTile(
            title: Text('Dica 2'),
            subtitle: Text('Descrição da dica 2'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const TipModal(tip: 'Esta é uma dica'),
          );
        },
        tooltip: 'Mostrar Dica',
        child: const Icon(Icons.help),
      ),
    );
  }
}
