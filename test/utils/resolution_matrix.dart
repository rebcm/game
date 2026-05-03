import 'package:flutter/material.dart';

class ResolutionMatrix {
  static const List<double> supportedResolutions = [
    320, // Minimum resolution for older devices
    360, // Common resolution for many modern smartphones
    414, // Resolution for larger smartphones like iPhone 11 Pro Max
    768, // Common tablet resolution
    1024, // Larger tablet resolution
  ];

  static const List<DeviceOrientation> supportedOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  static List<Size> getResolutions() {
    return supportedResolutions.map((resolution) => Size(resolution, resolution * 1.77)).toList();
  }

  static List<Size> getBreakpointSizes() {
    return [
      Size(320, 568), // Smallest iPhone
      Size(414, 896), // Largest iPhone
      Size(768, 1024), // iPad portrait
      Size(1024, 768), // iPad landscape
    ];
  }
}
