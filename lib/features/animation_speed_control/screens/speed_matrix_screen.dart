import 'package:flutter/material.dart';
import 'package:passdriver/features/animation_speed_control/providers/speed_matrix_provider.dart';
import 'package:provider/provider.dart';

class SpeedMatrixScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpeedMatrixProvider()..loadSpeedMatrix(),
      child: Consumer<SpeedMatrixProvider>(
        builder: (context, provider, child) {
          return DataTable(
            columns: [
              DataColumn(label: Text('Velocidade (m/s)')),
              DataColumn(label: Text('Velocidade de Animação')),
            ],
            rows: provider.speedMatrix
                .map((matrix) => DataRow(cells: [
                      DataCell(Text(matrix.speed.toString())),
                      DataCell(Text(matrix.animationSpeed.toString())),
                    ]))
                .toList(),
          );
        },
      ),
    );
  }
}
