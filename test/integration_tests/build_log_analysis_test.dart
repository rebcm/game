import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('analyze build logs', () async {
    final logFile = File('build_logs.log');
    final result = await Process.run('./scripts/build_log_analysis/analyze_build_logs.sh', [logFile.path]);
    expect(result.exitCode, 0);
  });
}
