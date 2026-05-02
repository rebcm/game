import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rebcm/features/audio_controls/domain/entities/volume_guard.dart';
import 'package:rebcm/features/audio_controls/presentation/bloc/volume_bloc.dart';

void main() {
  final volumeGuard = VolumeGuard();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VolumeBloc(volumeGuard)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rebeca\'s Game',
      home: // Your home widget here,
    );
  }
}
