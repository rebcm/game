import 'package:flutter/material.dart';
import 'package:game/widgets/volume_control.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: VolumeControl(),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await HardwareVolumeControl.volumeUp();
              },
              child: Text('Volume Up'),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () async {
                await HardwareVolumeControl.volumeDown();
              },
              child: Text('Volume Down'),
            ),
          ],
        ),
      ),
    );
  }
}

class HardwareVolumeControl {
  static Future<void> volumeUp() async {
  }

  static Future<void> volumeDown() async {
  }
}
