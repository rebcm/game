import 'package:flutter/material.dart';
class EdgeCasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edge Cases'),
      ),
      body: ListView(
        children: [
          ListTile(title: Text('Colisões em alta velocidade (tunneling)'))
          ListTile(title: Text('Compressão de objetos entre paredes'))
          ListTile(title: Text('Comportamento de empilhamento de itens físicos'))
        ],
      ),
    );
  }
}
