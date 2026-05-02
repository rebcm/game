class StutteringKPI {
  static const int fpsThreshold = 55;
  static const int jankFramesThreshold = 10;

  bool isStuttering(int fps, int jankFrames) {
    return fps < fpsThreshold || jankFrames > jankFramesThreshold;
  }
}
