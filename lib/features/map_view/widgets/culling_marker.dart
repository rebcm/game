import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CullingMarker extends StatefulWidget {
  final LatLng point;
  final Widget child;

  const CullingMarker({Key? key, required this.point, required this.child}) : super(key: key);

  @override
  State<CullingMarker> createState() => _CullingMarkerState();
}

class _CullingMarkerState extends State<CullingMarker> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return _isVisible
      ? Marker(
          point: widget.point,
          width: 20,
          height: 20,
          builder: (ctx) => widget.child,
        )
      : const SizedBox.shrink();
  }

  void updateVisibility(MapCamera camera) {
    final isVisible = camera.visibleBounds.contains(widget.point);
    if (_isVisible != isVisible) {
      setState(() {
        _isVisible = isVisible;
      });
    }
  }
}
