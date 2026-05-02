import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioTest extends ConsumerWidget {
  const AudioTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teste de Áudio')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Implement audio test logic here
          },
          child: const Text('Iniciar Teste'),
        ),
      ),
    );
  }
}
