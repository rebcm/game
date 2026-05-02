class StutteringKPI {
  final int fpsThreshold;
  final int jankFramesThreshold;

  StutteringKPI({required this.fpsThreshold, required this.jankFramesThreshold});

  factory StutteringKPI.fromFile(String filePath) {
    // TODO: implement reading KPI from file
    return StutteringKPI(fpsThreshold: 55, jankFramesThreshold: 10);
  }
}
