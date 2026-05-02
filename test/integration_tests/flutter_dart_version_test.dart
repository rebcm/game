import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rebcm/utils/version_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('deve verificar versão do Flutter e Dart', (tester) async {
    final flutterVersion = await Process.run('flutter', ['--version']);
    final dartVersion = await Process.run('dart', ['--version']);
    final flutterVersionString = flutterVersion.stdout.toString().split('\n').first.split(' ').last;
    final dartVersionString = dartVersion.stdout.toString().split(' ').last.split(',').first;
    expect(VersionUtils.isValidFlutterVersion(flutterVersionString), true);
    expect(VersionUtils.isValidDartVersion(dartVersionString), true);
  });
}
