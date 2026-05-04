import 'package:flutter/material.dart';

class RebecaWalkProcedural extends StatefulWidget {
  @override
  _RebecaWalkProceduralState createState() => _RebecaWalkProceduralState();
}

class _RebecaWalkProceduralState extends State<RebecaWalkProcedural> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animationController.value * 100, 0),
                child: Icon(Icons.directions_walk, size: 100),
              );
            },
          ),
        ),
      ),
    );
  }
}
