import 'package:flutter/material.dart';
import 'package:three.dart';

class ThreeDObject with ChangeNotifier {
  late Object3D _object;

  ThreeDObject() {
    _object = Object3D();
  }

  Object3D get object => _object;
}
