import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rebcm/features/mobile_controls/widgets/joystick.dart';
import 'package:rebcm/features/mobile_controls/widgets/action_button.dart';
import 'package:rebcm/features/mobile_controls/widgets/inventory_button.dart';

class MobileControls extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 20,
          bottom: 20,
          child: Joystick(
            onDirectionChanged: (details) {
              // Handle joystick direction change
            },
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: ActionButton(
            onPressed: () {
              // Handle action button press
            },
          ),
        ),
        Positioned(
          right: 80,
          bottom: 20,
          child: InventoryButton(
            onPressed: () {
              // Handle inventory button press
            },
          ),
        ),
      ],
    );
  }
}
