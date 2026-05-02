import 'package:flutter/material.dart';
import 'package:passdriver/features/gameplay/models/physics_event.dart';

class PhysicsEventProvider with ChangeNotifier {
  List<PhysicsEvent> _events = [];

  List<PhysicsEvent> get events => _events;

  void addEvent(PhysicsEvent event) {
    _events.add(event);
    notifyListeners();
  }

  void clearEvents() {
    _events.clear();
    notifyListeners();
  }
}
