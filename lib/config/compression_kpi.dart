class CompressionKPI {
  final double targetSizeReduction;
  final double acceptableQualityLoss;

  CompressionKPI({required this.targetSizeReduction, required this.acceptableQualityLoss});

  factory CompressionKPI.fromArtifacts(String targetSizeReduction, String acceptableQualityLoss) {
    return CompressionKPI(
      targetSizeReduction: double.parse(targetSizeReduction),
      acceptableQualityLoss: double.parse(acceptableQualityLoss),
    );
  }
}
