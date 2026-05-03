import 'package:flutter/material.dart';
import 'package:game/utils/ui_integration/ui_flow_integrator.dart';

class TutorialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
      ),
      body: Center(
        child: Text('Tela de tutorial'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UIFlowIntegrator().injectTips(context);
        },
        tooltip: 'Mostrar Dica',
        child: Icon(Icons.info),
      ),
    );
  }
}
