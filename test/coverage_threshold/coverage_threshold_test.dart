import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('coverage threshold', () {
    final coverageFile = File('coverage/lcov.info');
    expect(coverageFile.existsSync(), isTrue);

    final coverageContent = coverageFile.readAsStringSync();
    final lines = coverageContent.split('\n');
    final coverageLines = lines.where((line) => line.startsWith('SF:')).toList();
    final totalLines = coverageLines.length;
    final coveredLines = lines.where((line) => line.startsWith('DA:') && !line.endsWith(',0')).length;

    final coveragePercentage = (coveredLines / totalLines) * 100;
    expect(coveragePercentage, greaterThanOrEqualTo(80));
  });
}
