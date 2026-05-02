import 'package:flame/game.dart';
import 'package:rebcm/utils/garbage_collector.dart';

class RebecaGame extends FlameGame {
  @override
  void update(double dt) {
    super.update(dt);
    // Trigger garbage collection periodically
    if (dt % 60 == 0) {
      GarbageCollector.collect();
    }
  }
}
