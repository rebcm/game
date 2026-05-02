import Intl.message('package:passdriver/features/sound_effects/providers/sound_effects_provider.dart');

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
                await soundEffectsProvider.playSound(Intl.message('block_placed'));
              },
              child: Text(Intl.message('Colocar Bloco')),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound(Intl.message('block_broken'));
              },
              child: Text(Intl.message('Quebrar Bloco')),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound(Intl.message('jump'));
              },
              child: Text(Intl.message('Pular')),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound(Intl.message('fly'));
              },
              child: Text(Intl.message('Voar')),
            ),
            ElevatedButton(
              onPressed: () async {
                await soundEffectsProvider.playSound(Intl.message('inventory_open'));
              },
              child: Text(Intl.message('Abrir Inventário')),
            ),
          ],
        ),
      ),
    );
  }
}

