import 'package:flutter/material.dart';

class ScreenConfig {
  static const double minWidth = 320;
  static const double maxWidth = 414;
  static const double minHeight = 568;
  static const double maxHeight = 896;

  static Size getSmallScreenSize() => Size(minWidth, minHeight);
  static Size getLargeScreenSize() => Size(maxWidth, maxHeight);

  static List<Size> getScreenSizes() => [
        getSmallScreenSize(),
        Size(minWidth, maxHeight),
        Size(maxWidth, minHeight),
        getLargeScreenSize(),
      ];
}
