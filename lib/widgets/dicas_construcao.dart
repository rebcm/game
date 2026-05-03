import 'package:flutter/material.dart';
import 'package:rebcm/utils/constants/constantes.dart';

class DicasConstrucao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: Constantes.dicasConstrucao.map((dica) => ListTile(title: Text(dica))).toList(),
      ),
    );
  }
}
