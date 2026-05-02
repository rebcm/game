import 'dart:io';

class LogAnalyzer {
  static void analyzeLogs(String logPath) {
    final logFile = File(logPath);
    if (logFile.existsSync()) {
      final logs = logFile.readAsLinesSync();
      for (var log in logs) {
        if (log.contains('error')) {
          print('Erro encontrado: $log');
        }
      }
    } else {
      print('Arquivo de log não encontrado: $logPath');
    }
  }
}
