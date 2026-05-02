import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/upload_chunks/presentation/upload_chunks_notifier.dart';

void main() {
  group('UploadChunksNotifier', () {
    late UploadChunksNotifier notifier;

    setUp(() {
      notifier = UploadChunksNotifier();
    });

    test('should handle multiple chunk uploads', () async {
      await notifier.uploadChunks(['chunk1', 'chunk2', 'chunk3']);
      expect(notifier.uploadStatus, UploadStatus.success);
    });

    test('should handle large file uploads', () async {
      await notifier.uploadLargeFile('large_file');
      expect(notifier.uploadStatus, UploadStatus.success);
    });
  });
}
