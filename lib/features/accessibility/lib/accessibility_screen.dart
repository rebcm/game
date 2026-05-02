import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
class AccessibilityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessibilidade'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Opções de acessibilidade', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              ListTile(
                title: Text('Remapear teclas'),
                onTap: () {
                  // Implementar remapeamento de teclas
                },
              ),
              ListTile(
                title: Text('Configurações de leitores de tela'),
                onTap: () {
                  // Implementar configurações de leitores de tela
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
