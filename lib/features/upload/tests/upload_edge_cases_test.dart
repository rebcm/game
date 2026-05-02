import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/upload/upload_provider.dart';

void main() {
  test('upload timeout test', () async {
    final uploadProvider = UploadProvider();
    expect(await uploadProvider.uploadFile('test_file.txt', timeout: Duration(seconds: 1)), throwsA(isA<TimeoutException>()));
  });

  test('upload connection failure test', () async {
    final uploadProvider = UploadProvider();
    expect(await uploadProvider.uploadFile('test_file.txt', apiUrl: 'https://invalid-url.com'), throwsA(isA<SocketException>()));
  });
}
