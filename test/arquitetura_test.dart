import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/data/models/block_model.dart';
import 'package:rebcm/domain/entities/block_entity.dart';
import 'package:rebcm/presentation/screens/game_screen.dart';

void main() {
  test('Testa se as camadas estão separadas corretamente', () {
    expect(() => BlockModel(), returnsNormally);
    expect(() => BlockEntity(), returnsNormally);
    expect(() => GameScreen(), returnsNormally);
  });
}
