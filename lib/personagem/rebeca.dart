import 'package:flutter/material.dart';
import 'package:game/personagem/estados/estado_rebeca.dart';

class Rebeca extends StatefulWidget {
  @override
  _RebecaState createState() => _RebecaState();
}

class _RebecaState extends State<Rebeca> {
  final MaquinaEstadosRebeca _maquinaEstados = MaquinaEstadosRebeca();

  @override
  Widget build(BuildContext context) {
    return _maquinaEstados.renderizar();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
