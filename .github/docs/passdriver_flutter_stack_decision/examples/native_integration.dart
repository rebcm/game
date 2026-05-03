import 'package:flutter/material.dart';
import 'dart:ffi';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo de Integração Nativa'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Exemplo de chamada a uma função nativa
              // dynamic result = nativeFunction();
              // print(result);
            },
            child: Text('Chamar Função Nativa'),
          ),
        ),
      ),
    );
  }
}

// Exemplo de binding para uma função nativa
// typedef NativeFunctionType = Int32 Function();
// typedef DartFunctionType = int Function();
// DynamicLibrary _lib = DynamicLibrary.open('libnative.so');
// DartFunctionType nativeFunction = _lib.lookupFunction<NativeFunctionType, DartFunctionType>('native_function');

