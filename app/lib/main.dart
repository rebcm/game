import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/input/input_manager.dart';
import 'features/gameplay/gameplay_listener.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InputManager()),
        ChangeNotifierProxyProvider<InputManager, GameplayListener>(
          create: (_) => GameplayListener(Provider.of<InputManager>(_)),
          update: (_, inputManager, gameplayListener) => GameplayListener(inputManager),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construção Criativa',
      home: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: Provider.of<InputManager>(context, listen: false).handleKeyEvent,
        child: MouseRegion(
          onHover: (event) => Provider.of<InputManager>(context, listen: false).handleMouseEvent(event),
          child: Listener(
            onPointerSignal: (event) {
              if (event is PointerScrollEvent) {
                Provider.of<InputManager>(context, listen: false).handleScrollEvent(event.scrollDelta.dy);
              }
            },
            child: // Your existing game widget tree here,
          ),
        ),
      ),
    );
  }
}
