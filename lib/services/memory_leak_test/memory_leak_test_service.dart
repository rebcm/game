import 'package:flutter/material.dart';

class MemoryLeakTestService with ChangeNotifier {
  // Service to test memory leak

  void initEstadoJogo() {
    // Initialize estado_jogo.dart
  }

  void destroyEstadoJogo() {
    // Destroy estado_jogo.dart
  }

  int getMemoryUsage() {
    // Return the current memory usage
    return 0; // Implement later with actual memory usage data
  }
}
