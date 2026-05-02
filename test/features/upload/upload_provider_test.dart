import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/upload/upload_provider.dart';

void main() {
  test('uploadFile success', () async {
    final provider = UploadProvider();
    final filePath = '/path/to/file';
    final result = await provider.uploadFile(filePath);
    expect(result, true);
  });

  test('verifyChecksum success', () async {
    final provider = UploadProvider();
    final filePath = '/path/to/file';
    final expectedChecksum = 'expected_checksum';
    final result = await provider.verifyChecksum(filePath, expectedChecksum);
    expect(result, true);
  });
}
