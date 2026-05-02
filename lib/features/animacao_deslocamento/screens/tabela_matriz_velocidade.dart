import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/animacao_deslocamento/providers/matriz_velocidade_provider.dart';

class TabelaMatrizVelocidade extends StatefulWidget {
  @override
  _TabelaMatrizVelocidadeState createState() => _TabelaMatrizVelocidadeState();
}

class _TabelaMatrizVelocidadeState extends State<TabelaMatrizVelocidade> {
  @override
  void initState() {
    super.initState();
    Provider.of<MatrizVelocidadeProvider>(context, listen: false).carregarMatrizVelocidade();
  }

  @override
  Widget build(BuildContext context) {
    final matrizVelocidadeProvider = Provider.of<MatrizVelocidadeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela de Matriz de Velocidade'),
      ),
      body: Center(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Velocidade de Deslocamento (m/s)')),
            DataColumn(label: Text('Velocidade de Reprodução')),
          ],
          rows: matrizVelocidadeProvider.matrizVelocidade
              .map((matriz) => DataRow(cells: [
                    DataCell(Text(matriz.velocidadeDeslocamento.toString())),
                    DataCell(Text(matriz.velocidadeReproducao.toString())),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
