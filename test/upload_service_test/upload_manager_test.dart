import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload_service/upload_manager.dart';
import 'package:game/services/upload_service/upload_retry_manager.dart';
import 'package:mockito/mockito.dart';

class MockUploadRetryManager extends Mock implements UploadRetryManager {}

void main() {
  late UploadManager uploadManager;
  late MockUploadRetryManager mockUploadRetryManager;

  setUp(() {
    mockUploadRetryManager = MockUploadRetryManager();
    uploadManager = UploadManager(mockUploadRetryManager);
  });

  test('should call retryUpload when uploading data', () async {
    when(mockUploadRetryManager.retryUpload(any)).thenAnswer((_) async => true);

    await uploadManager.uploadData([]);

    verify(mockUploadRetryManager.retryUpload(any)).called(1);
  });
}
