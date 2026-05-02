import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UploadStatus { idle, uploading, success, failure }

class UploadChunksNotifier extends StateNotifier<UploadStatus> {
  UploadChunksNotifier() : super(UploadStatus.idle);

  Future<void> uploadChunks(List<String> chunks) async {
    state = UploadStatus.uploading;
    try {
      // Implement chunk upload logic here
      state = UploadStatus.success;
    } catch (e) {
      state = UploadStatus.failure;
    }
  }

  Future<void> uploadLargeFile(String file) async {
    state = UploadStatus.uploading;
    try {
      // Implement large file upload logic here
      state = UploadStatus.success;
    } catch (e) {
      state = UploadStatus.failure;
    }
  }
}

final uploadChunksNotifierProvider = StateNotifierProvider<UploadChunksNotifier, UploadStatus>((ref) {
  return UploadChunksNotifier();
});
