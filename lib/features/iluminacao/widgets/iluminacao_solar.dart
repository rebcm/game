import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class IluminacaoSolar extends StatefulWidget {
  @override
  _IluminacaoSolarState createState() => _IluminacaoSolarState();
}

class _IluminacaoSolarState extends State<IluminacaoSolar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            onTap: (point) {},
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.black.withOpacity(0.5),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
