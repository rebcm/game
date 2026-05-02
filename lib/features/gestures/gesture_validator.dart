import 'package:flutter/material.dart';

class GestureValidator with ChangeNotifier {
  bool validateGesture(String documentedGesture, String implementedGesture) {
    return documentedGesture == implementedGesture;
  }
}
