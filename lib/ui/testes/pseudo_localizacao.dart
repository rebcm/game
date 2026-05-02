import 'package:flutter/material.dart';
import 'package:rebcm/ui/hud.dart';

class PseudoLocalizacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pseudo Localização',
      home: Scaffold(
        body: Hud(
          // Força textos longos para teste de layout
          hotbarLabels: List.generate(9, (index) => 'Texto muito longo para teste $index'),
        ),
      ),
    );
  }
}
