import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/utils/dispose.dart';

class ExistingScreen extends StatefulWidget {
  @override
  _ExistingScreenState createState() => _ExistingScreenState();
}

class _ExistingScreenState extends State<ExistingScreen> with TickerProviderStateMixin {
  final List<TextEditingController> _textEditingControllers = [];
  final List<AnimationController> _animationControllers = [];_animationController = AnimationController> _animationControllers = [];();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  final List<StreamSubscription> _streamSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _textEditingControllers.add(TextEditingController());
    _animationControllers.add(AnimationController(vsync: this));_animationController = AnimationController(vsync: this));();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    // Initialize stream subscriptions
  }

  @override
  void dispose() {
    DisposeUtils.disposeTextEditingControllers(_textEditingControllers);
    DisposeUtils.disposeAnimationControllers(_animationControllers);_animationController = AnimationControllers(_animationControllers);();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    DisposeUtils.cancelStreamSubscriptions(_streamSubscriptions);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Existing Screen'),
      ),
      body: Center(
        child: Text('Existing Screen'),
      ),
    );
  }
}
