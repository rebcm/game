import 'package:flutter/material.dart';
import 'package:passdriver/features/mundos_do_usuario/presentation/mundos_do_usuario_view_model.dart';
import 'package:provider/provider.dart';

class MundosDoUsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MundosDoUsuarioViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mundos do Usuário'),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.mundosDoUsuario.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(viewModel.mundosDoUsuario[index].nome),
                );
              },
            ),
    );
  }
}
