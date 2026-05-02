import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/audio_compression_test/audio_compression_test_screen.dart';
void main() {
  testWidgets('AudioCompressionTestScreen has a button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AudioCompressionTestScreen()));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
