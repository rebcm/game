import 'package:flutter/material.dart';
import 'package:game/features/tips/context_mapping/tip_context_mapper.dart';

class TipWidget extends StatelessWidget {
  final String context;
  final String trigger;

  const TipWidget({Key? key, required this.context, required this.trigger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (TipContextMapper.shouldShowTooltip(context, trigger)) {
      return Tooltip(
        message: 'This is a tooltip for $trigger',
        child: const Icon(Icons.info),
      );
    } else if (TipContextMapper.shouldShowModal(context, trigger)) {
      return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Modal Title'),
                content: Text('This is a modal for $trigger'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: const Text('Show Modal'),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
