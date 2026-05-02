import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app_name/features/salvamento/stores/salvamento_store.dart';
import 'package:your_app_name/features/salvamento/repositories/salvamento_repository.dart';
import 'package:your_app_name/features/salvamento/services/salvamento_service.dart';

void main() {
  final salvamentoService = SalvamentoService();
  final salvamentoRepository = SalvamentoRepositoryImpl(salvamentoService);
  final salvamentoStore = SalvamentoStore(salvamentoRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => salvamentoStore),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Game',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salvamentoStore = Provider.of<SalvamentoStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Mundo Salvo: ${salvamentoStore.mundoSalvo}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await salvamentoStore.carregarMundo();
              },
              child: Text('Carregar Mundo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await salvamentoStore.salvarMundo('novo_mundo');
              },
              child: Text('Salvar Mundo'),
            ),
          ],
        ),
      ),
    );
  }
}
