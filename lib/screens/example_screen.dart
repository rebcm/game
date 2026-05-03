import 'package:flutter/material.dart';
import 'package:game/widgets/text_widgets/auto_size_text_wrapper.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Screen'),
      ),
      body: Center(
        child: AutoSizeTextWrapper(
          text: 'This is a very long text that should be auto-sized and ellipsized when it overflows.',
          style: TextStyle(fontSize: 24),
          maxLines: 2,
        ),
      ),
    );
  }
}
