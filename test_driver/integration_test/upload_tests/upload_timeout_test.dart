import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:game/main.dart' as app;
import 'package:dio/dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Large file upload timeout test', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final dio = Dio();
    try {
      await dio.post(
        'https://api.example.com/upload',
        data: Stream.fromIterable(List.generate(1000000, (i) => i)),
        options: Options(
          headers: {
            'Content-Length': 1000000,
          },
        ),
      ).timeout(Duration(seconds: 5));
      fail('Expected TimeoutException');
    } on TimeoutException catch (e) {
      expect(e.toString(), contains('TimeoutException'));
    }
  });
}
