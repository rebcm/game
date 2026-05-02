import 'dart:ffi';
import 'package:flutter/services.dart';

class CPUMonitor {
  static const String _channel = 'com.rebecaalves.construcao_criativa/cpu';

  final MethodChannel _methodChannel = MethodChannel(_channel);

  Future<double> getCpuUsage() async {
    try {
      final double cpuUsage = await _methodChannel.invokeMethod('getCpuUsage');
      return cpuUsage;
    } on PlatformException catch (e) {
      print('Failed to get CPU usage: ${e.message}');
      return 0;
    }
  }
}
