import 'dart:io';

class MemUtils {
  static int getMemoryUsage(Process process) {
    final output = Process.runSync('pmap', ['-d', process.pid.toString()]);
    final memoryUsage = output.stdout.toString().split('\n').lastWhere((line) => line.contains('total'), orElse: () => '');
    final memoryValue = memoryUsage.split(' ').last;
    return int.parse(memoryValue);
  }
}
