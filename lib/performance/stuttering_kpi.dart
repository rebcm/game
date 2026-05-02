class StutteringKPI {
  static const int maxFramesPerSecond = 60;
  static const int minFramesPerSecond = 55;
  static const double maxJankFramesPercentage = 0.05;

  static bool isStuttering(int framesPerSecond, double jankFramesPercentage) {
    return framesPerSecond < minFramesPerSecond || jankFramesPercentage > maxJankFramesPercentage;
  }
}
