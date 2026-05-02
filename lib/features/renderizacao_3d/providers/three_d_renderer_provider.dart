import 'package:flutter/material.dart';
import 'package:three_d_renderer/models/three_d_object.dart';

class ThreeDRendererProvider extends InheritedWidget {
  final ThreeDObject _threeDObject;

  ThreeDRendererProvider({required Widget child}) 
    : _threeDObject = ThreeDObject(), 
      super(child: child);

  static ThreeDRendererProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThreeDRendererProvider>();
  }

  @override
  bool updateShouldNotify(ThreeDRendererProvider oldWidget) {
    return _threeDObject != oldWidget._threeDObject;
  }
}
