import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/r2_service/r2_service.dart';
import 'package:http/http.dart' as http;

void main() {
  late R2Service _r2Service;

  setUp(() {
    _r2Service = R2Service(http.Client(), 'test-bucket');
  });

  testWidgets('putObject returns mocked object url', (tester) async {
    final objectUrl = await _r2Service.putObject('test-object', []);
    expect(objectUrl, 'mocked-object-url');
  });

  testWidgets('getObject returns mocked object content', (tester) async {
    final objectContent = await _r2Service.getObject('test-object');
    expect(objectContent, utf8.encode('mocked-object-content'));
  });

  testWidgets('deleteObject does not throw', (tester) async {
    await expectLater(_r2Service.deleteObject('test-object'), completes);
  });

  testWidgets('listObjects returns mocked object list', (tester) async {
    final objectList = await _r2Service.listObjects();
    expect(objectList, ['mocked-object-1', 'mocked-object-2']);
  });
}
