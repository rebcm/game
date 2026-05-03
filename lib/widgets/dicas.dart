import 'package:flutter/material.dart';

class Dicas extends StatefulWidget {
  const Dicas({Key? key}) : super(key: key);

  @override
  State<Dicas> createState() => _DicasState();
}

class _DicasState extends State<Dicas> {
  final List<String> _dicas = [
    'Dica 1: Construa uma casa!',
    'Dica 2: Explore o mundo!',
    'Dica 3: Crie algo incrível!',
  ];

  int _indiceDicaAtual = 0;

  void _proximaDica() {
    setState(() {
      _indiceDicaAtual = (_indiceDicaAtual + 1) % _dicas.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _dicas[_indiceDicaAtual],
          key: const Key('dicas'),
        ),
        ElevatedButton(
          onPressed: _proximaDica,
          child: const Text('Próxima Dica'),
          key: const Key('proximaDica'),
        ),
      ],
    );
  }
}
