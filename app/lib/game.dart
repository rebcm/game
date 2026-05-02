import 'package:flame/game.dart';
import 'package:rebcm/player/rebeca.dart';

class Game extends FlameGame {
  late Rebeca _rebeca;

  @override
  Future<void> onLoad() async {
    _rebeca = Rebeca();
    add(_rebeca);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update game state
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render game
  }
}
