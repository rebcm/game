import 'package:flutter_test/flutter_test.dart';
import 'package:game/widgets/audio_slider.dart';

void main() {
  testWidgets('Testa se o slider de volume é exibido corretamente', (tester) async {
    await tester.pumpWidget(AudioSlider(key: Key('volume_slider')));
    expect(find.byKey(Key('volume_slider')), findsOneWidget);
  });
}
