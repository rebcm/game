import 'package:flutter/material.dart';
import 'package:game/utils/debug_profiler.dart';
import 'package:provider/provider.dart';

class DebugOverlay extends StatelessWidget {
  const DebugOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DebugProfiler>(
      builder: (context, profiler, child) {
        if (!profiler.isEnabled) return const SizedBox.shrink();

        return Positioned(
          top: 0,
          left: 0,
          child: Container(
            color: Colors.red,
            child: const Text('Debug Mode'),
          ),
        );
      },
    );
  }
}
