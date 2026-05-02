import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class RideHailingPerformanceOptimizer {
  static const int chunkSize = 10;

  List<LatLng> optimizeMarkers(List<LatLng> markers) {
    List<LatLng> optimizedMarkers = [];
    for (int i = 0; i < markers.length; i += chunkSize) {
      optimizedMarkers.add(markers[i]);
    }
    return optimizedMarkers;
  }
}
