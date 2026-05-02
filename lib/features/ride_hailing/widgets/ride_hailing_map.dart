import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_provider.dart';

class RideHailingMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rideHailingProvider = context.watch<RideHailingProvider>();

    return FlutterMap(
      options: MapOptions(
        center: LatLng(-23.55052, -46.633308),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
      ],
    );
  }
}
