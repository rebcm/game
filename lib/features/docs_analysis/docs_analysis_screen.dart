import 'package:flutter/material.dart';
import 'package:passdriver/features/docs_analysis/widgets/doc_analysis_widget.dart';

class DocsAnalysisScreen extends StatelessWidget {
  const DocsAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise de Compreensibilidade'),
      ),
      body: const DocAnalysisWidget(),
    );
  }
}
