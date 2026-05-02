import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/modo_criativo_provider.dart';
class ModoCriativoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModoCriativoProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modo Criativo'),
        ),
        body: Center(
          child: Consumer<ModoCriativoProvider>(
            builder: (context, modoCriativoProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Voar: ${modoCriativoProvider.voarHabilitado ? 'Habilitado' : 'Desabilitado'}'),
                  ElevatedButton(
                    onPressed: modoCriativoProvider.toggleVoar,
                    child: Text('Alternar Voar'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
