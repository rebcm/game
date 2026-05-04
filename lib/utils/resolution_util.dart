import 'package:flutter/material.dart';

class ResolutionUtil {
  static const List<double> supportedResolutions = [320, 375, 414];

  static bool isSupportedResolution(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return supportedResolutions.contains(width);
  }
}
