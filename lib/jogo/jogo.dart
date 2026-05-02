import 'package:flutter/material.dart';
import 'package:rebcm/services/notificacao/notificacao_service.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  final NotificacaoService _notificacaoService = NotificacaoService();

  @override
  void initState() {
    super.initState();
    _notificacaoService.notificarNeuronAPI('jogo_iniciado');
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Implemente o jogo aqui
  }
}
