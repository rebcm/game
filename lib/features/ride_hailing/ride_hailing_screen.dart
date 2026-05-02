import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/ride_hailing/providers/ride_hailing_provider.dart';
import 'package:passdriver/features/ride_hailing/widgets/ride_hailing_animation.dart';

class RideHailingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RideHailingProvider(vsync: Navigator.of(context)),
      child: Scaffold(
        body: Center(
          child: RideHailingAnimation(),
        ),
      ),
    );
  }
}
