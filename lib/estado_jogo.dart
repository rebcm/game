import 'package:flutter/material.dart';
import 'package:leak_tracker/leak_tracker.dart';

class EstadoJogo extends StatefulWidget {
  @override
  EstadoJogoState createState() => EstadoJogoState();
}

class EstadoJogoState extends State<EstadoJogo> with LeakTracking {
  List<Timer> timers = [];

  @override
  void initState() {
    super.initState();
    // Inicializa os timers
    timers.add(Timer.periodic(Duration(seconds: 1), (timer) {}));
  }

  @override
  void dispose() {
    for (var timer in timers) {
      timer.cancel();
    }
    super.dispose();
  }

  List<Leak> get timersLeaks => LeakTracking.getLeaks(
        trackedObjects: timers,
      );
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
