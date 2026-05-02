import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class NoiseCalculationScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de Ruído'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await compute(calculateNoise, []);
          },
          child: Text('Calcular Ruído'),
        ),
      ),
    );
  }
}
