import 'package:flutter/material.dart';
import 'package:game/services/telemetria/telemetria_dicas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TelemetriaDicas _telemetriaDicas = TelemetriaDicas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca\'s Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Dicas Exibidas: ${_telemetriaDicas.dicasExibidas}'),
            Text('Dicas Ignoradas: ${_telemetriaDicas.dicasIgnoradas}'),
            ElevatedButton(
              onPressed: () {
                _telemetriaDicas.dicaExibida();
              },
              child: Text('Exibir Dica'),
            ),
            ElevatedButton(
              onPressed: () {
                _telemetriaDicas.dicaIgnorada();
              },
              child: Text('Ignorar Dica'),
            ),
          ],
        ),
      ),
    );
  }
}
