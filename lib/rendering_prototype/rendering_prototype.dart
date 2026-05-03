import 'package:flutter/material.dart';
import 'package:game/rendering_prototype/services/rendering_service.dart';

class RenderingPrototype extends StatefulWidget {
  @override
  _RenderingPrototypeState createState() => _RenderingPrototypeState();
}

class _RenderingPrototypeState extends State<RenderingPrototype> {
  final RenderingService _renderingService = RenderingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rendering Prototype'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _renderingService.render,
          child: Text('Render Cube'),
        ),
      ),
    );
  }
}
