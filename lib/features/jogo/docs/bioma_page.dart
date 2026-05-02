import 'package:flutter/material.dart';
import 'package:passdriver/features/jogo/docs/bioma_descricao.dart';
import 'package:passdriver/features/jogo/models/bioma.dart';

class BiomaPage extends StatelessWidget {
  final List<Bioma> biomas = [
    Bioma(nome: 'Amazônia', descricao: 'Descrição da Amazônia'),
    Bioma(nome: 'Cerrado', descricao: 'Descrição do Cerrado'),
    Bioma(nome: 'Caatinga', descricao: 'Descrição da Caatinga'),
    Bioma(nome: 'Mata Atlântica', descricao: 'Descrição da Mata Atlântica'),
    Bioma(nome: 'Pampa', descricao: 'Descrição do Pampa'),
    Bioma(nome: 'Pantanal', descricao: 'Descrição do Pantanal'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biomas do Jogo'),
      ),
      body: ListView.builder(
        itemCount: biomas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(biomas[index].nome),
            subtitle: BiomaDescricao(bioma: biomas[index]),
          );
        },
      ),
    );
  }
}
