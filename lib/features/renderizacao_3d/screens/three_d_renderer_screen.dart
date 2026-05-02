import 'package:flutter/material.dart';
import 'package:three_d_renderer/providers/three_d_renderer_provider.dart';

class ThreeDRendererScreen extends StatefulWidget {
  @override
  _ThreeDRendererScreenState createState() => _ThreeDRendererScreenState();
}

class _ThreeDRendererScreenState extends State<ThreeDRendererScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Renderização 3D'),
      ),
      body: ThreeDRendererProvider(
        child: Center(
          child: Text('Renderização 3D em desenvolvimento'),
        ),
      ),
    );
  }
}
