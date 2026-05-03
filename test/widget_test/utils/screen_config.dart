import 'package:flutter/material.dart';

class ScreenConfig {
  static const List<double> breakpoints = [320, 360, 414, 768, 1024];
  static const List<DeviceOrientation> orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ];

  static Size getScreenSize(double breakpoint, DeviceOrientation orientation) {
    if (orientation == DeviceOrientation.portraitUp) {
      return Size(breakpoint, breakpoint * 1.77777777778); // 16:9 aspect ratio
    } else {
      return Size(breakpoint * 1.77777777778, breakpoint);
    }
  }
}
