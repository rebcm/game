import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late DioMock dio;

  setUp(() {
    dio = DioMock();
  });

  test('should make a GET request', () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ''), statusCode: 200));
    final response = await dio.get('');
    expect(response.statusCode, 200);
  });
}

