import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio_reproduction/widgets/audio_player_widget.dart';

void main() {
  testWidgets('AudioPlayerWidget reproduz áudio', (tester) async {
    await tester.pumpWidget(AudioPlayerWidget());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    // Verificar se o áudio foi reproduzido corretamente
  });
}
