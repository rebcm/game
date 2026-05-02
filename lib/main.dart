import 'package:flutter/material.dart';
import 'package:rebcm/engine_3d/engine_3d.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:rebcm/fisica/fisica.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca Voxel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterGlContext _glContext;
  late Engine3D _engine3D;
  late Fisica _fisica;

  @override
  void initState() {
    super.initState();
    _glContext = FlutterGlContext();
    _engine3D = Engine3D(_glContext);
    _fisica = Fisica();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rebeca Voxel'),
      ),
      body: Center(
        child: GlSurface(
          onContextCreated: (glContext) {
            _engine3D.render();
          },
        ),
      ),
    );
  }
}
