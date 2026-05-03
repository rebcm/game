import 'package:flutter/material.dart';
import 'package:game/utils/bloco_referencia.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bloco Referência'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: BlocoReferencia.imprimirBlocos,
            child: Text('Imprimir Blocos'),
          ),
        ),
      ),
    );
  }
}
import 'package:game/services/isolate_guard/isolate_guard.dart';

void main() async {
  // Existing main logic...

  // Ensure isolates are killed on app exit
  IsolateGuard.killAllIsolates();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Existing widget tree...

    return WillPopScope(
      onWillPop: () async {
        IsolateGuard.killAllIsolates();
        return true;
      },
      child: // Existing widget tree...
    );
  }
}
