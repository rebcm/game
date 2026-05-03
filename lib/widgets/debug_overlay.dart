import 'package:flutter/material.dart';
import 'package:game/utils/debug_logger.dart';
import 'package:provider/provider.dart';

class DebugOverlay extends StatelessWidget {
  const DebugOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final debugLogger = context.watch<DebugLogger>();
    return debugLogger.isEnabled
        ? Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Text(
                'Debug Mode',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
