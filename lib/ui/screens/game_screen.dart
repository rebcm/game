import 'package:flutter/material.dart';
import 'package:rebcm/ui/widgets/error/error_handler_widget.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorHandlerWidget(
      child: // Your game screen content here
      Scaffold(
        body: Center(
          child: Text('Game Screen'),
        ),
      ),
    );
  }
}
