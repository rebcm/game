import 'package:flutter/material.dart';

class PaginaAjuda extends StatelessWidget {
  const PaginaAjuda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajuda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Aqui vão as informações de ajuda.', style: Theme.of(context).textTheme.bodyText2),
      ),
    );
  }
}
