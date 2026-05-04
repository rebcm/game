import 'package:game/utils/dispose_helpers.dart';
import 'package:flutter/material.dart';
import 'package:rebcm/utils/dispose.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;_animationController = AnimationController _animationController;();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
  late TextEditingController _textEditingController;
  late StreamSubscription _streamSubscription;
  final DisposeController _disposeController = DisposeController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);_animationController = AnimationController(vsync: this);();
    @override
    void dispose() {
      _animationController.dispose();
      super.dispose();
    }
    _textEditingController = TextEditingController();
    _streamSubscription = Stream.periodic(Duration(seconds: 1)).listen((_) {});

    _disposeController.addDisposable(() => _animationController.dispose());
    _disposeController.addDisposable(() => _textEditingController.dispose());
    _disposeController.addDisposable(() => _streamSubscription.cancel());
  }

  @override
  void dispose() {
    _disposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Game Screen'),
      ),
    );
  }
}
