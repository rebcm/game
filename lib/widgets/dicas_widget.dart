import 'package:flutter/material.dart';
import 'package:game/constants/dicas_construcao.dart';

class DicasWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: DicasConstrucao.dicas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(DicasConstrucao.dicas[index]),
          );
        },
      ),
    );
  }
}
