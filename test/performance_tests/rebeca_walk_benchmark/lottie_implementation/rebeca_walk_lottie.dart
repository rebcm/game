import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RebecaWalkLottie extends StatefulWidget {
  @override
  _RebecaWalkLottieState createState() => _RebecaWalkLottieState();
}

class _RebecaWalkLottieState extends State<RebecaWalkLottie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Lottie.asset('assets/rebeca_walk.json'),
        ),
      ),
    );
  }
}
