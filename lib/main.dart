import 'package:provider/provider.dart';
import 'package:passdriver/features/character_animation/providers/character_animation_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterAnimationProvider()),
      ],
      child: MyApp(),
    ),
  );
}
