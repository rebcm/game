import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:passdriver/features/fisica_3d/providers/fisica_provider.dart';
import 'package:provider/provider.dart';

class TelaFisica3D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FisicaProvider>(
      builder: (context, fisicaProvider, child) {
        return FlutterMap(
          options: MapOptions(
            center: LatLng(-23.55052, -46.633308),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: fisicaProvider.objetos.map((objeto) {
                return Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(objeto.x, objeto.y),
                  builder: (ctx) => Icon(Icons.place),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
