import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Volume control adjusts system volume', (tester) async {
    await tester.pumpWidget(MyApp());

    final audioManager = AudioManager.instance;

    await tester.drag(find.byType(Slider), Offset(0.5, 0));
    await tester.pumpAndSettle();

    expect(audioManager.volume, greaterThan(0.0));
    expect(audioManager.volume, lessThan(1.0));
  });
}
