import 'package:flutter/material.dart';

class InputService {
  final List<String> _movementKeys = ['w', 'a', 's', 'd'];

  bool isMovementKeyPressed(RawKeyEvent event) {
    return _movementKeys.contains(event.character?.toLowerCase());
  }
}
