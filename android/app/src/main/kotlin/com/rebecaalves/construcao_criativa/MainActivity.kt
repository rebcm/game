package com.rebecaalves.construcao_criativa

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
  private val CPU_CHANNEL = "com.rebecaalves.construcao_criativa/cpu"

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CPU_CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "getCpuUsage") {
        result.success(getCpuUsage())
      } else {
        result.notImplemented()
      }
    }
  }

  private fun getCpuUsage(): Double {
    // Implement CPU usage calculation here
    return 0.5
  }
}
