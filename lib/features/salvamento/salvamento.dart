import Intl.message('package:flutter/material.dart');
import Intl.message('package:provider/provider.dart');
import Intl.message('package:passdriver/features/salvamento/salvamento_provider.dart');

class SalvamentoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salvamentoProvider = Provider.of<SalvamentoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('Salvamento')),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(Intl.message('Carregar Mundo')),
          onPressed: () async {
            try {
              await salvamentoProvider.carregarMundo();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(Intl.message('Mundo carregado com sucesso!'))),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(Intl.message('Erro ao carregar mundo: '))),
              );
            }
          },
        ),
      ),
    );
  }
}
