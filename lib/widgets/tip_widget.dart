import 'package:flutter/material.dart';

class TipWidget extends StatefulWidget {
  @override
  _TipWidgetState createState() => _TipWidgetState();
}

class _TipWidgetState extends State<TipWidget> {
  String _currentTip = 'Dica: Construa usando diferentes blocos';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentTip = 'Dica: Experimente mudar a cor dos blocos';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTip,
      key: const Key('tip_text'),
      style: const TextStyle(fontSize: 16),
    );
  }
}
