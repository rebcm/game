import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passdriver/features/upload/providers/upload_notifier.dart';

void main() {
  group('UploadNotifier', () {
    late UploadNotifier notifier;

    setUp(() {
      notifier = UploadNotifier();
    });

    test('initial state is false', () {
      expect(notifier.state, false);
    });

    test('state is true during upload', () async {
      notifier.uploadData();
      expect(notifier.state, true);
    });

    test('state is false after upload', () async {
      await notifier.uploadData();
      expect(notifier.state, false);
    });

    test('retry logic works', () async {
      // Implement test for retry logic
    });
  });
}
