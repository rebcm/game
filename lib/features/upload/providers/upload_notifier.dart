import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadNotifier extends StateNotifier<bool> {
  UploadNotifier() : super(false);

  Future<void> uploadData() async {
    state = true;
    try {
      // Simulating upload logic
      await Future.delayed(const Duration(seconds: 1));
      // Call the actual upload function here
    } catch (e) {
      // Retry logic will be implemented here
    } finally {
      state = false;
    }
  }

  Future<void> retryUpload() async {
    // Retry logic implementation
  }
}

final uploadNotifierProvider = StateNotifierProvider<UploadNotifier, bool>((ref) {
  return UploadNotifier();
});
