import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/features/ride_hailing/ride_hailing_performance_optimizer.dart';

class RideHailingScreen extends StatefulWidget {
  @override
  _RideHailingScreenState createState() => _RideHailingScreenState();
}

class _RideHailingScreenState extends State<RideHailingScreen> {
  List<LatLng> markers = [];

  @override
  Widget build(BuildContext context) {
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
        MarkerLayerOptions(
          markers: RideHailingPerformanceOptimizer().optimizeMarkers(markers).map((latLng) {
            return Marker(
              width: 40.0,
              height: 40.0,
              point: latLng,
              builder: (ctx) => Icon(Icons.place),
            );
          }).toList(),
        ),
      ],
    );
  }
}
