import 'package:flutter/material.dart';
import 'package:game/services/telemetria/telemetria_dicas.dart';

class DicaWidget extends StatefulWidget {
  final String idDica;
  final String textoDica;

  const DicaWidget({Key? key, required this.idDica, required this.textoDica}) : super(key: key);

  @override
  State<DicaWidget> createState() => _DicaWidgetState();
}

class _DicaWidgetState extends State<DicaWidget> {
  final TelemetriaDicas _telemetriaDicas = TelemetriaDicas();

  @override
  void initState() {
    super.initState();
    _telemetriaDicas.dicaVisualizada(widget.idDica);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _telemetriaDicas.dicaInteragida(widget.idDica);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(widget.textoDica),
      ),
    );
  }
}
