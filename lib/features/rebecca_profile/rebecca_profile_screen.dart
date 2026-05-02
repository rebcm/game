import 'package:flutter/material.dart';
import 'package:passdriver/features/rebecca_profile/models/rebecca_character.dart';
import 'package:passdriver/features/rebecca_profile/widgets/rebecca_profile_card.dart';

class RebeccaProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rebeccaCharacter = RebeccaCharacter(
      description: 'Personagem principal da história',
      appearance: 'Cabelos castanhos, olhos azuis',
      style: 'Moderno e elegante',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil da Rebeca'),
      ),
      body: Center(
        child: RebeccaProfileCard(character: rebeccaCharacter),
      ),
    );
  }
}
