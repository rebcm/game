import 'package:memory_info/memory_info.dart';

class MemoryInfoHelper {
  static Future<int> getMemoryUsage() async {
    final memoryInfo = await MemoryInfo().getMemoryInfo();
    return memoryInfo.totalMemory;
  }
}
