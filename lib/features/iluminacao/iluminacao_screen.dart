import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class IluminacaoScreen extends StatefulWidget {
  @override
  _IluminacaoScreenState createState() => _IluminacaoScreenState();
}

class _IluminacaoScreenState extends State<IluminacaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
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
    );
  }
}
