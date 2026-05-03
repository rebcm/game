import 'package:flutter/material.dart';

class StateDisplayWidget extends StatelessWidget {
  final String state;

  const StateDisplayWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(state);
  }
}
