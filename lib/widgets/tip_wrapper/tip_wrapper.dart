import 'package:flutter/material.dart';
import 'package:game/services/tip_service/tip_service.dart';

class TipWrapper extends StatelessWidget {
  final Widget child;

  const TipWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
