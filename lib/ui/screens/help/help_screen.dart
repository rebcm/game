import 'package:flutter/material.dart';
import 'package:rebcm/game/ui/widgets/tips/tip_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
      ),
      body: ListView(
        children: const [
          TipCard(
            title: 'Dica 1',
            description: 'Descrição da dica 1',
          ),
          TipCard(
            title: 'Dica 2',
            description: 'Descrição da dica 2',
          ),
        ],
      ),
    );
  }
}
