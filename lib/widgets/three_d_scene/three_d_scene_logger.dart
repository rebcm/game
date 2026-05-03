import 'package:flutter/material.dart';

class ThreeDSceneLogger extends StatelessWidget {
  final Widget child;

  const ThreeDSceneLogger({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // Log scroll notifications if needed
          return true;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Log layout builder calls if needed
            return child;
          },
        ),
      ),
    );
  }
}
