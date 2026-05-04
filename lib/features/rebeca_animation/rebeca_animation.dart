import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RebecaAnimation extends StatefulWidget {
  @override
  _RebecaAnimationState createState() => _RebecaAnimationState();
}

class _RebecaAnimationState extends State<RebecaAnimation> with TickerProviderStateMixin { with AnimationControllerDisposer {_animationController = AnimationControllerDisposer {();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late Animation<double> _armAnimation;
  late Animation<double> _legAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(_animationController = AnimationController(();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _armAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _legAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                // Draw Rebeca's body
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
                // Draw Rebeca's arms
                Transform.translate(
                  offset: Offset(_armAnimation.value * 50, 0),
                  child: Container(
                    width: 20,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
                Transform.translate(
                  offset: Offset(-_armAnimation.value * 50, 0),
                  child: Container(
                    width: 20,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
                // Draw Rebeca's legs
                Transform.translate(
                  offset: Offset(_legAnimation.value * 25, 50),
                  child: Container(
                    width: 20,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
                Transform.translate(
                  offset: Offset(-_legAnimation.value * 25, 50),
                  child: Container(
                    width: 20,
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController.reset();
          _animationController.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
