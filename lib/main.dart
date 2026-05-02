import 'package:flutter/material.dart';
import 'package:rebcm/engine_3d/engine_3d.dart';
import 'package:rebcm/fisica/fisica.dart';
import 'package:flutter_gl/flutter_gl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s World',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Engine3D _engine3d;
  late Fisica _fisica;
  late FlutterGl _flutterGl;

  @override
  void initState() {
    super.initState();
    _flutterGl = FlutterGl();
    _engine3d = Engine3D(_flutterGl);
    _fisica = Fisica(_engine3d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterGlWidget(
          onCreated: (gl) {
            _flutterGl = gl;
            _engine3d.render();
            _fisica.atualizar();
          },
        ),
      ),
    );
  }
}
