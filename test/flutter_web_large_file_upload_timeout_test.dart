import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/upload_service.dart';

void main() {
  test('Flutter web large file upload timeout test', () async {
    // Simulate large file upload timeout
    final uploadService = UploadService();
    final response = await uploadService.uploadLargeFile();
    expect(response, isA<TimeoutException>());
  });
}
