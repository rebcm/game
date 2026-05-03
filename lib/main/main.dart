import 'package:flutter/material.dart';
import 'package:rebcm/main/app.dart';
import 'package:rebcm/providers/music_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final musicProvider = MusicProvider();
  await musicProvider.init();
  runApp(MyApp());
}
