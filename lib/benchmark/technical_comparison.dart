import 'package:flutter/material.dart';

class TechnicalComparison extends StatefulWidget {
  @override
  _TechnicalComparisonState createState() => _TechnicalComparisonState();
}

class _TechnicalComparisonState extends State<TechnicalComparison> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comparação Técnica'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Implementação dos benchmarks aqui
            Text('Benchmarks em desenvolvimento'),
          ],
        ),
      ),
    );
  }
}
