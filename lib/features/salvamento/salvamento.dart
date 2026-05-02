import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/salvamento/salvamento_provider.dart';

class SalvamentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salvamentoProvider = Provider.of<SalvamentoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Salvamento'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Carregar Mundo'),
          onPressed: () async {
            try {
              await salvamentoProvider.carregarMundo();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Mundo carregado com sucesso!')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao carregar mundo: ')),
              );
            }
          },
        ),
      ),
    );
  }
}
