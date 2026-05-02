import 'package:flutter/material.dart';
import 'package:rebcm/models/characters/rebeca/rebeca_animation.dart';

class RebecaCharacter extends StatefulWidget {
  @override
  _RebecaCharacterState createState() => _RebecaCharacterState();
}

class _RebecaCharacterState extends State<RebecaCharacter> with TickerProviderStateMixin {
  late RebecaAnimation _rebecaAnimation;

  @override
  void initState() {
    super.initState();
    _rebecaAnimation = RebecaAnimation(this);
  }

  @override
  void dispose() {
    _rebecaAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rebecaAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 0),
          child: Stack(
            children: [
              // Body
              Container(
                width: 20,
                height: 40,
                color: Colors.brown,
              ),
              // Arms
              Transform.rotate(
                angle: _rebecaAnimation.armsAnimation.value,
                child: Container(
                  width: 10,
                  height: 20,
                  color: Colors.brown,
                ),
              ),
              Transform.rotate(
                angle: -_rebecaAnimation.armsAnimation.value,
                child: Container(
                  width: 10,
                  height: 20,
                  color: Colors.brown,
                ),
              ),
              // Legs
              Transform.translate(
                offset: Offset(5, 20),
                child: Transform.rotate(
                  angle: _rebecaAnimation.legsAnimation.value,
                  child: Container(
                    width: 5,
                    height: 20,
                    color: Colors.brown,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-5, 20),
                child: Transform.rotate(
                  angle: -_rebecaAnimation.legsAnimation.value,
                  child: Container(
                    width: 5,
                    height: 20,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
