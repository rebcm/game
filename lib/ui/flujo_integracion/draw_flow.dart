import 'package:flutter/material.dart';

class DrawFlow extends StatefulWidget {
  @override
  _DrawFlowState createState() => _DrawFlowState();
}

class _DrawFlowState extends State<DrawFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluxo de Integração da UI'),
      ),
      body: Center(
        child: Text('Desenhar Fluxo de Integração da UI'),
      ),
    );
  }
}
