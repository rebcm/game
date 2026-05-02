class PerformanceKPI {
  static const String fpsThresholdFile = '.github/workflows/performance_kpi/fps_threshold.txt';
  static const String jankFramesThresholdFile = '.github/workflows/performance_kpi/jank_frames_threshold.txt';

  static Future<int> getFpsThreshold() async {
    final file = File(fpsThresholdFile);
    final contents = await file.readAsString();
    return int.parse(contents.trim());
  }

  static Future<int> getJankFramesThreshold() async {
    final file = File(jankFramesThresholdFile);
    final contents = await file.readAsString();
    return int.parse(contents.trim());
  }

  static bool isStuttering(int fps, int jankFrames) async {
    final fpsThreshold = await getFpsThreshold();
    final jankFramesThreshold = await getJankFramesThreshold();
    return fps < fpsThreshold || jankFrames > jankFramesThreshold;
  }
}
