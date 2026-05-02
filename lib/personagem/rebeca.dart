import 'package:flutter/material.dart';
import 'package:rebcm/personagem/estados/maquina_estados.dart';
import 'package:provider/provider.dart';

class Rebeca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MaquinaEstados(),
      child: Consumer<MaquinaEstados>(
        builder: (context, maquinaEstados, child) {
          return AnimatedBuilder(
            animation: maquinaEstados,
            builder: (context, child) {
              // Lógica de animação baseada no estado atual
              switch (maquinaEstados.estadoAtual) {
                case EstadoPersonagem.parado:
                  return Icon(Icons.person, size: 50);
                case EstadoPersonagem.andando:
                  return Icon(Icons.directions_walk, size: 50);
                case EstadoPersonagem.pulando:
                  return Icon(Icons.flight, size: 50);
                default:
                  return Icon(Icons.person, size: 50);
              }
            },
          );
        },
      ),
    );
  }
}
