import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RideHailingMap extends StatefulWidget {
  @override
  _RideHailingMapState createState() => _RideHailingMapState();
}

class _RideHailingMapState extends State<RideHailingMap> with TickerProviderStateMixin {
  late final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onMapReady: () {
          _mapController.mapEventStream.listen((event) {
            if (event is MapEventMove) {
              // handle map move event
            }
          });
        },
        initialCenter: LatLng(-23.55052, -46.633308),
        initialZoom: 12,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        RepaintBoundary(
          child: // animation widget here,
        ),
      ],
    );
  }
}
