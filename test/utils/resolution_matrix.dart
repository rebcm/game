import 'package:flutter/material.dart';

class ResolutionMatrix {
  static const List<Size> supportedResolutions = [
    Size(320, 568), // iPhone SE
    Size(360, 640), // Old Android devices
    Size(414, 896), // iPhone 11 Pro Max
  ];
}
