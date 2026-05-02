import 'package:flutter/material.dart';
import 'package:passdriver/features/self_healing/storage_limit_screen.dart';

class StorageLimitTestWidget extends StatelessWidget {
  const StorageLimitTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StorageLimitScreen(),
    );
  }
}
