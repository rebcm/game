import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/features/map_view/widgets/culling_marker.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final List<CullingMarker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        onMapEvent: (event) {
          if (event is MapEventMoveEnd || event is MapEventZoomEnd) {
            _updateMarkersVisibility(event.camera);
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(markers: _markers.map((marker) => marker.build(context)).toList()),
      ],
    );
  }

  void _updateMarkersVisibility(MapCamera camera) {
    for (var marker in _markers) {
      marker.updateVisibility(camera);
    }
  }

  void addMarker(CullingMarker marker) {
    setState(() {
      _markers.add(marker);
    });
  }
}
