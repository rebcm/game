import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/documentation_checklist/providers/documentation_checklist_provider.dart';

class DocumentationChecklistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist de Aceitação de Conteúdo'),
      ),
      body: Consumer<DocumentationChecklistProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.checklists.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(provider.checklists[index].title),
              );
            },
          );
        },
      ),
    );
  }
}
