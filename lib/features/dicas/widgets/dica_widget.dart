import 'package:flutter/material.dart';
import 'package:game/features/dicas/contexto/mapeamento_contexto.dart';

class DicaWidget extends StatelessWidget {
  final String telaAtual;
  final String? gatilho;

  const DicaWidget({Key? key, required this.telaAtual, this.gatilho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!MapeamentoContexto.deveMostrarDica(telaAtual, gatilho)) return const SizedBox.shrink();

    final tipoDica = MapeamentoContexto.tipoDica(telaAtual, gatilho!);
    if (tipoDica == 'Tooltip') {
      return Tooltip(
        message: 'Dica contextual para $gatilho',
        child: const Icon(Icons.info),
      );
    } else if (tipoDica == 'Modal') {
      return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Dica Instrutiva'),
              content: const Text('Esta é uma dica instrutiva'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: const Text('Mostrar Dica'),
      );
    }

    return const SizedBox.shrink();
  }
}
