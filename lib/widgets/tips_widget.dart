import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TipsWidget extends StatelessWidget {
  const TipsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Intl.message('tip'),
      overflow: TextOverflow.visible,
      maxLines: 2,
      style: const TextStyle(fontSize: 14),
    );
  }
}
