import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RebecaWalkRive extends StatefulWidget {
  @override
  _RebecaWalkRiveState createState() => _RebecaWalkRiveState();
}

class _RebecaWalkRiveState extends State<RebecaWalkRive> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RiveAnimation.asset('assets/rebeca_walk.riv'),
        ),
      ),
    );
  }
}
