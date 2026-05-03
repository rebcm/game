import 'package:flutter/material.dart';

class ResolutionTestConfig {
  static const List<Size> supportedResolutions = [
    Size(320, 480), // iPhone SE
    Size(480, 800), // Old Android devices
    // Add more resolutions as needed
  ];

  static const List<double> supportedDevicePixelRatios = [
    1.5,
    2.0,
    // Add more device pixel ratios as needed
  ];
}
