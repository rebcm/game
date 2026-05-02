import 'package:flutter/material.dart';

class MensagemErro extends StatelessWidget {
  final String mensagem;

  const MensagemErro({Key? key, required this.mensagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.redAccent,
      child: Text(mensagem, style: const TextStyle(color: Colors.white)),
    );
  }
}
