import 'package:flutter/material.dart';
import 'package:rebcm/utils/dispose_helper.dart';

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with TickerProviderStateMixin {
  final List<TextEditingController> _textControllers = [];
  final List<AnimationController> _animationControllers = [];
  final List<StreamSubscription> _streamSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _textControllers.add(TextEditingController());
    _animationControllers.add(AnimationController(vsync: this));
    // Initialize stream subscriptions
  }

  @override
  void dispose() {
    DisposeHelper.disposeControllers(_textControllers);
    DisposeHelper.disposeAnimationControllers(_animationControllers);
    DisposeHelper.cancelStreamSubscriptions(_streamSubscriptions);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Screen'),
      ),
      body: Center(
        child: Text('Example Screen'),
      ),
    );
  }
}
