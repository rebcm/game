import 'package:flutter/material.dart';
import 'package:rebcm/ui/dicas/dicas_modal.dart';
import 'package:rebcm/ui/dicas/dicas_tooltip.dart';

class DicasWidget extends StatelessWidget {
  const DicasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DicasTooltip(mensagem: 'Dica: Clique aqui para mais informações'),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => showDialog(context: context, builder: (_) => DicasModal()),
          child: Text('Ver Dicas'),
        ),
      ],
    );
  }
}
