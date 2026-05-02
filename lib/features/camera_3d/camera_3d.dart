import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:passdriver/features/camera_3d/widgets/camera_3d_widget.dart';

class Camera3D extends StatefulWidget {
  @override
  _Camera3DState createState() => _Camera3DState();
}

class _Camera3DState extends State<Camera3D> {
  @override
  Widget build(BuildContext context) {
    return Camera3DWidget();
  }
}
