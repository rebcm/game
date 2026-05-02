import 'package:flutter/material.dart';
import 'package:passdriver/features/jogo/models/bioma.dart';

class BiomaDescricao extends StatelessWidget {
  final Bioma bioma;

  const BiomaDescricao({Key? key, required this.bioma}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(bioma.descricao);
  }
}
