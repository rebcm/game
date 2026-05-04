import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    this.renderConfigAppliedKey,
    this.startPerformanceCollectionKey,
    super.key,
  });

  final Key? renderConfigAppliedKey;
  final Key? startPerformanceCollectionKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construção Criativa da Rebeca',
      home: const MyHomePage(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            if (renderConfigAppliedKey != null)
              Container(key: renderConfigAppliedKey),
            if (startPerformanceCollectionKey != null)
              ElevatedButton(
                key: startPerformanceCollectionKey,
                onPressed: () {
                  // Coletar performance aqui
                },
                child: const Text('Iniciar Coleta de Performance'),
              ),
          ],
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Aplicar configurações de renderização aqui
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Construção Criativa da Rebeca'),
      ),
    );
  }
}
