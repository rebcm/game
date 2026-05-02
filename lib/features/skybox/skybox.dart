import 'package:flutter/material.dart';

class Skybox extends StatefulWidget {
  @override
  _SkyboxState createState() => _SkyboxState();
}

class _SkyboxState extends State<Skybox> with TickerProviderStateMixin {
  late AnimationController _dayNightController;
  late Animation<double> _dayNightAnimation;

  @override
  void initState() {
    super.initState();
    _dayNightController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();
    _dayNightAnimation = Tween<double>(begin: 0, end: 1).animate(_dayNightController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dayNightAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _dayNightAnimation.value < 0.5
                    ? Color.lerp(Colors.blue[100], Colors.deepPurple[900], _dayNightAnimation.value * 2)!
                    : Color.lerp(Colors.deepPurple[900], Colors.blue[100], (_dayNightAnimation.value - 0.5) * 2)!,
                _dayNightAnimation.value < 0.5
                    ? Color.lerp(Colors.blue[200], Colors.grey[800], _dayNightAnimation.value * 2)!
                    : Color.lerp(Colors.grey[800], Colors.blue[200], (_dayNightAnimation.value - 0.5) * 2)!,
              ],
            ),
          ),
          child: Stack(
            children: [
              _buildClouds(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClouds() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              child: Transform.translate(
                offset: Offset(_dayNightAnimation.value * constraints.maxWidth, 0),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 0,
              child: Transform.translate(
                offset: Offset(-_dayNightAnimation.value * constraints.maxWidth, 0),
                child: Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _dayNightController.dispose();
    super.dispose();
  }
}
