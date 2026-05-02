import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
class JogoScreen extends StatefulWidget {
  @override
  _JogoScreenState createState() => _JogoScreenState();
}
class _JogoScreenState extends State<JogoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo PassDriver'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-23.55052, -46.633308),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c']
          )
        ],
      )
    );
  }
}
