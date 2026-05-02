import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/transitions/providers/transition_provider.dart';

class TransitionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransitionProvider>();
    return Text(provider.state.toString());
  }
}
