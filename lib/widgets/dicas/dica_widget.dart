import 'package:flutter/material.dart';

class DicaWidget extends StatelessWidget {
  final String texto;

  const DicaWidget({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(texto),
    );
  }
}
