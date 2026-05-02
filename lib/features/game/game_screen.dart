import 'package:passdriver/features/sound_effects/providers/sound_effects_provider.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final soundEffectsProvider = SoundEffectsProvider();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound('block_placed');
              },
              child: Text('Colocar Bloco'),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound('block_broken');
              },
              child: Text('Quebrar Bloco'),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound('jump');
              },
              child: Text('Pular'),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound('fly');
              },
              child: Text('Voar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound('inventory_open');
              },
              child: Text('Abrir Inventário'),
            ),
          ],
        ),
      ),
    );
  }
}

