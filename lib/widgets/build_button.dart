import 'package:flutter/material.dart';
import 'package:rebcm/utils/performance_metrics.dart';

class BuildButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key(PerformanceMetrics.buildButtonKey),
      onPressed: () {
        // existing logic
      },
      child: Text('Build'),
    );
  }
}
