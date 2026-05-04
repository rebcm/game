import 'package:rive/rive.dart';

class RebecaAnimation extends StatefulWidget {
  @override
  _RebecaAnimationState createState() => _RebecaAnimationState();
}

class _RebecaAnimationState extends State<RebecaAnimation> {
  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rebeca_animation.riv',
      fit: BoxFit.cover,
    );
  }
}
