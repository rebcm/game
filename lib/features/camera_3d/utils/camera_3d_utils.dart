import 'package:flutter/material.dart';

class Camera3DUtils {
  static void animateCamera(MapController mapController, LatLng target) {
    mapController.animateTo(
      target,
      zoom: 16,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
