import 'package:flutter_test/flutter_test.dart';
import 'package:game/services/game_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Validate offset consistency between float32 and float64', (tester) async {
    final gameService = GameService();
    await gameService.init();

    final float32Offset = gameService.calculateOffset(useFloat64: false);
    final float64Offset = gameService.calculateOffset(useFloat64: true);

    expect(float32Offset, closeTo(float64Offset, 0.001));
  });
}
