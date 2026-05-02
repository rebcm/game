class RebeccaIdleAnimationConfig {
  static const double loopDuration = 2.0; // segundos
  static const double amplitude = 5.0; // pixels
  static const Curve easingFunction = Curves.easeInOutSine;

  RebeccaIdleAnimationConfig._();

  static RebeccaIdleAnimationConfig get instance => RebeccaIdleAnimationConfig._();
}
