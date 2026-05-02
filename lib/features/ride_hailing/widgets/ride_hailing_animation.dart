import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_provider.dart';

class RideHailingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Consumer<RideHailingProvider>(
        builder: (context, provider, child) {
          return AnimatedBuilder(
            animation: provider.animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: provider.animation.value,
                child: child,
              );
            },
            child: Icon(Icons.car_rental, size: 50),
          );
        },
      ),
    );
  }
}
