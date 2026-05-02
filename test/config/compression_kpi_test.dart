import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/config/compression_kpi.dart';

void main() {
  test('CompressionKPI from artifacts', () {
    const targetSizeReduction = '20.0';
    const acceptableQualityLoss = '5.0';

    final kpi = CompressionKPI.fromArtifacts(targetSizeReduction, acceptableQualityLoss);

    expect(kpi.targetSizeReduction, double.parse(targetSizeReduction));
    expect(kpi.acceptableQualityLoss, double.parse(acceptableQualityLoss));
  });
}
