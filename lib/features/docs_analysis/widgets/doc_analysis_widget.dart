import 'package:flutter/material.dart';

class DocAnalysisWidget extends StatefulWidget {
  const DocAnalysisWidget({super.key});

  @override
  State<DocAnalysisWidget> createState() => _DocAnalysisWidgetState();
}

class _DocAnalysisWidgetState extends State<DocAnalysisWidget> {
  final TextEditingController _controller = TextEditingController();
  String _analysisResult = '';

  void _analyzeComprehensibility() {
    final text = _controller.text;
    // Implement comprehensibility analysis logic here
    setState(() {
      _analysisResult = 'Análise realizada com sucesso!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Insira a descrição do jogo',
            ),
            maxLines: null,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _analyzeComprehensibility,
            child: const Text('Analisar'),
          ),
          const SizedBox(height: 16),
          Text(_analysisResult),
        ],
      ),
    );
  }
}
