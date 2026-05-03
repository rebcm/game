import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rebcm/blocos/blocos.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Blocos()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocos = context.watch<Blocos>().blocos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Blocos Disponíveis'),
      ),
      body: ListView.builder(
        itemCount: blocos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(blocos[index].nome),
            subtitle: Text(blocos[index].descricao),
          );
        },
      ),
    );
  }
}

