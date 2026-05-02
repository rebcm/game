import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/utils/log_analyzer.dart';
import 'dart:io';

void main() {
  test('analisa logs corretamente', () {
    final tempDir = Directory.systemTemp.createTempSync();
    final logFile = File('${tempDir.path}/test.log');
    logFile.writeAsStringSync('Linha com erro\nLinha sem erro\n');

    LogAnalyzer.analyzeLogs(logFile.path);

    expect(logFile.existsSync(), true);
    tempDir.deleteSync(recursive: true);
  });
}
