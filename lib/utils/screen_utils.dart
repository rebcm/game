import 'package:flutter/material.dart';

class ScreenUtils {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool isMinimumResolution(BuildContext context, List<Size> minimumResolutions) {
    final screenSize = getScreenSize(context);
    return minimumResolutions.any((resolution) => screenSize.width <= resolution.width && screenSize.height <= resolution.height);
  }
}
