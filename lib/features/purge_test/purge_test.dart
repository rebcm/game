import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurgeTest extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Teste de Purga')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Implementar lógica de teste de purga aqui
          },
          child: Text('Executar Teste de Purga'),
        ),
      ),
    );
  }
}
