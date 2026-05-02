import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/map_view/providers/map_culling_provider.dart';
import 'package:passdriver/features/map_view/widgets/culling_marker.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    return ChangeNotifierProvider(
      create: (_) => MapCullingProvider(mapController),
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: LatLng(-23.55052, -46.633308),
                builder: (ctx) => CullingMarker(
                  latLng: LatLng(-23.55052, -46.633308),
                  child: const Icon(Icons.place),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
