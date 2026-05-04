import 'dart:io';

void main() {
  final result = Process.runSync('flutter', ['test']);
  if (result.exitCode != 0) {
    print('Testes falharam com código de saída ${result.exitCode}');
    exit(result.exitCode);
  }

  final output = result.stdout.toString();
  final failedTests = output.split('\n').where((line) => line.contains('FAIL')).length;
  final passedTests = output.split('\n').where((line) => line.contains('PASS')).length;

  print('Testes executados:');
  print('  Passados: $passedTests');
  print('  Falhas: $failedTests');

  if (failedTests > 0) {
    print('Testes falharam');
    exit(1);
  }
}
