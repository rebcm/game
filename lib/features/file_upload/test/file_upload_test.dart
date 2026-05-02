import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/file_upload/file_upload_provider.dart';

void main() {
  test('file upload flow', () async {
    final fileUploadProvider = FileUploadProvider();
    final file = File('test_file.txt');
    await file.writeAsString('test content');
    await fileUploadProvider.uploadFile(file);
    final uploadedFiles = await fileUploadProvider.getUploadedFiles();
    expect(uploadedFiles.length, 1);
  });
}
