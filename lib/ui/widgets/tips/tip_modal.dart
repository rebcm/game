import 'package:flutter/material.dart';
import 'package:rebcm/game/ui/widgets/tips/tip_card.dart';

class TipModal extends StatelessWidget {
  final String title;
  final String description;

  const TipModal({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: TipCard(
        title: title,
        description: description,
      ),
    );
  }
}
