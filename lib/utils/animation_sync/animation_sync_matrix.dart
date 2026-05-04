class AnimationSyncMatrix {
  static const List<List<double>> matrix = [
    [0.0, 0.0],
    [0.5, 0.5],
    [1.0, 1.0],
    [1.5, 1.5],
    [2.0, 2.0],
  ];

  static double getPlaybackRate(double velocity) {
    for (int i = 0; i < matrix.length - 1; i++) {
      if (velocity >= matrix[i][0] && velocity <= matrix[i + 1][0]) {
        return _interpolate(
          velocity,
          matrix[i][0],
          matrix[i + 1][0],
          matrix[i][1],
          matrix[i + 1][1],
        );
      }
    }
    return matrix.last[1];
  }

  static double _interpolate(double x, double x0, double x1, double y0, double y1) {
    return y0 + (x - x0) * (y1 - y0) / (x1 - x0);
  }
}
