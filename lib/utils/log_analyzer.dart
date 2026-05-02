import 'dart:io';

class LogAnalyzer {
  Future<void> analyzeLogFile(String logFilePath) async {
    final logFile = File(logFilePath);
    if (await logFile.exists()) {
      print('Analyzing log file...');
      final logContent = await logFile.readAsString();
      final errors = logContent.split('\n').where((line) => line.toLowerCase().contains('error'));
      errors.forEach((error) => print(error));
    } else {
      print('Log file not found.');
    }
  }
}
