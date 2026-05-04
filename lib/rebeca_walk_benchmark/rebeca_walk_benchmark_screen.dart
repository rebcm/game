import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

class RebecaWalkBenchmarkScreen extends StatefulWidget {
  const RebecaWalkBenchmarkScreen({Key? key}) : super(key: key);

  @override
  State<RebecaWalkBenchmarkScreen> createState() => _RebecaWalkBenchmarkScreenState();
}

class _RebecaWalkBenchmarkScreenState extends State<RebecaWalkBenchmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/rebeca_walk_lottie.json'),
            RiveAnimation.asset('assets/rebeca_walk_rive.riv'),
            // Add procedural animation here
          ],
        ),
      ),
    );
  }
}
