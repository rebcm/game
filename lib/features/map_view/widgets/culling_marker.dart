import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/map_view/providers/map_culling_provider.dart';

class CullingMarker extends StatelessWidget {
  final LatLng latLng;
  final Widget child;

  const CullingMarker({Key? key, required this.latLng, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cullingProvider = context.watch<MapCullingProvider>();
    return cullingProvider.isMarkerVisible(latLng) ? child : const SizedBox.shrink();
  }
}
