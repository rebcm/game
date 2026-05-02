import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Camera3DWidget extends StatefulWidget {
  @override
  _Camera3DWidgetState createState() => _Camera3DWidgetState();
}

class _Camera3DWidgetState extends State<Camera3DWidget> {
  bool _isFirstPerson = true;

  void _togglePerspective() {
    setState(() {
      _isFirstPerson = !_isFirstPerson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(-23.55052, -46.633308),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
            ),
          ],
        ),
        Positioned(
          top: 40,
          right: 20,
          child: ElevatedButton(
            onPressed: _togglePerspective,
            child: Text(_isFirstPerson ? 'Terceira Pessoa' : 'Primeira Pessoa'),
          ),
        ),
      ],
    );
  }
}
