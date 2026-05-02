import 'package:flame/game.dart';
import 'package:rebcm/lighting/sun_light.dart';
import 'package:rebcm/lighting/soft_shadows.dart';

class RebecaGame extends FlameGame {
  late SunLight _sunLight;
  late SoftShadows _softShadows;

  @override
  Future<void> onLoad() async {
    _sunLight = SunLight();
    _softShadows = SoftShadows();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _sunLight.update(dt);
    _softShadows.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sunLight.render(canvas);
    _softShadows.render(canvas, _sunLight._direction);
  }
}
