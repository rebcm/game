import 'package:flutter/material.dart';
import 'package:passdriver/features/rebecca_profile/models/rebecca_character.dart';

class RebeccaProfileCard extends StatelessWidget {
  final RebeccaCharacter character;

  RebeccaProfileCard({required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Descrição: ${character.description}'),
          Text('Aparência: ${character.appearance}'),
          Text('Estilo: ${character.style}'),
        ],
      ),
    );
  }
}
