import 'dart:developer' as dev;

class MemoryService {
  Future<int> getMemoryUsage() async {
    final memoryInfo = await dev.Process.run('ps', ['-p', '${dev.Process.pid}', '-o', 'rss']);
    final memoryUsage = int.parse(memoryInfo.stdout.toString().trim().split('\n').last.trim());
    return memoryUsage * 1024; // Convert to bytes
  }
}
