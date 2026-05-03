import 'package:flutter/material.dart';
import 'package:rebcm/controllers.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  late MyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MyController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _controller.textController),
        AnimatedBuilder(
          animation: _controller.animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _controller.animationController.value,
              child: child,
            );
          },
          child: FlutterLogo(size: 100),
        ),
      ],
    );
  }
}
