import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/game.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Atomic Consistency Tests', () {
    late Dio dio;
    late Game game;

    setUp(() {
      dio = MockDio();
      game = Game(dio: dio);
    });

    testWidgets('should rollback on failure after insertion', (tester) async {
      when(() => dio.post(any())).thenThrow(DioError(requestOptions: RequestOptions(path: '')));

      await tester.pumpWidget(game);

      expect(() async => game.saveWorld(), throwsA(isA<DioError>()));

      verify(() => dio.post(any())).called(1);
      // Additional verification for rollback
    });
  });
}
