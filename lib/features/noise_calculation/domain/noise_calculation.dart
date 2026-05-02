import 'dart:isolate';
void calculateNoise(List<dynamic> args) {
  // implement noise calculation logic here
  SendPort? sendPort = args[0];
  sendPort?.send(null);
}
