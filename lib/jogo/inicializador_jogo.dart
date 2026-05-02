import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/persistencia/gerenciador_persistencia.dart';

class InicializadorJogo extends StatelessWidget {
  final Widget child;

  const InicializadorJogo({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<GerenciadorPersistencia>(context, listen: false).inicializar(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
