import 'package:flutter/material.dart';
import 'package:game/features/tips/context_mapping/tip_context_mapper.dart';

class TipDecider extends StatelessWidget {
  final String context;
  final String trigger;
  final Widget tooltip;
  final Widget modal;

  const TipDecider({
    Key? key,
    required this.context,
    required this.trigger,
    required this.tooltip,
    required this.modal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (TipContextMapper.shouldShowTooltip(context, trigger)) {
      return tooltip;
    } else if (TipContextMapper.shouldShowModal(context, trigger)) {
      return modal;
    }
    return const SizedBox.shrink();
  }
}
