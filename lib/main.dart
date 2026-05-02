import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:passdriver/features/audio_optimization/audio_optimization_feature.dart';
import 'package:passdriver/providers/audio_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: AudioOptimizationFeature(),
    ),
  );
}
