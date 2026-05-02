import 'package:flutter/foundation.dart';

enum PhysicsEventType { collision, forceApplied }

class PhysicsEvent {
  final PhysicsEventType type;
  final double intensity;

  PhysicsEvent({required this.type, required this.intensity});
}
