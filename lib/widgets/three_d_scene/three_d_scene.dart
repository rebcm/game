import 'package:flutter/material.dart';

class ThreeDScene extends StatefulWidget {
  @override
  _ThreeDSceneState createState() => _ThreeDSceneState();
}

class _ThreeDSceneState extends State<ThreeDScene> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RepaintBoundary(
      child: // existing 3D scene widget tree,
    );
  }
}
