import 'package:flutter/material.dart';
import 'package:game/ui/configuracoes/volume_control.dart';

class TelaConfiguracoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: ListView(
        children: [
          VolumeControl(),
        ],
      ),
    );
  }
}
