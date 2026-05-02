import 'package:flutter/material.dart';

class StorageLimitScreen extends StatefulWidget {
  const StorageLimitScreen({super.key});

  @override
  State<StorageLimitScreen> createState() => _StorageLimitScreenState();
}

class _StorageLimitScreenState extends State<StorageLimitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro de Limite de Armazenamento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Erro de Limite de Armazenamento'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuccessScreen()),
                );
              },
              child: const Text('Resolver Manualmente'),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucesso'),
      ),
      body: const Center(
        child: Text('Execução retomada com sucesso'),
      ),
    );
  }
}
