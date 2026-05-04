import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/upload_service/upload_service.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late UploadService uploadService;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    uploadService = UploadService(dio);
  });

  test('uploadData success', () async {
    dioAdapter.onPost(
      'https://example.com/upload',
      (server) => server.reply(200, {}),
      data: any,
      queryParameters: anyNamed('queryParameters'),
      headers: anyNamed('headers'),
    );

    await uploadService.uploadData([1, 2, 3], 'https://example.com/upload');
  });

  test('uploadData with connection error and retry success', () async {
    dioAdapter.onPost(
      'https://example.com/upload',
      (server) {
        server.reply(200, {});
        throw DioException(
          requestOptions: RequestOptions(path: 'https://example.com/upload'),
          type: DioExceptionType.connectionError,
        );
      },
      data: any,
      queryParameters: anyNamed('queryParameters'),
      headers: anyNamed('headers'),
    ).then((_) {
      dioAdapter.onPost(
        'https://example.com/upload',
        (server) => server.reply(200, {}),
        data: any,
        queryParameters: anyNamed('queryParameters'),
        headers: anyNamed('headers'),
      );
    });

    await uploadService.uploadData([1, 2, 3], 'https://example.com/upload');
  });

  test('uploadData with connection error and retry failure', () async {
    dioAdapter.onPost(
      'https://example.com/upload',
      (server) => throw DioException(
        requestOptions: RequestOptions(path: 'https://example.com/upload'),
        type: DioExceptionType.connectionError,
      ),
      data: any,
      queryParameters: anyNamed('queryParameters'),
      headers: anyNamed('headers'),
    );

    expect(
      () async => await uploadService.uploadData([1, 2, 3], 'https://example.com/upload'),
      throwsException,
    );
  });
}
