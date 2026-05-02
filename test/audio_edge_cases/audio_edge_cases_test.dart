import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/services/audio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioService extends Mock implements AudioService {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AudioService audioService;
  late SharedPreferences sharedPreferences;

  setUp(() {
    audioService = MockAudioService();
    sharedPreferences = MockSharedPreferences();

    when(() => sharedPreferences.getDouble('volume')).thenReturn(0.5);
    when(() => audioService.volume).thenReturn(0.5);
  });

  test('test volume zero vs mute', () async {
    when(() => audioService.mute).thenReturn(true);
    expect(audioService.volume, 0.0);
    verify(() => audioService.mute).called(1);
  });

  test('test troca de dispositivo de saída de áudio', () async {
    // Simulando a troca de dispositivo
    when(() => audioService.setOutputDevice('newDevice')).thenAnswer((_) async => true);
    await audioService.setOutputDevice('newDevice');
    verify(() => audioService.setOutputDevice('newDevice')).called(1);
  });

  test('test persistência de volume via SharedPreferences', () async {
    when(() => sharedPreferences.setDouble('volume', 0.7)).thenAnswer((_) async => true);
    await sharedPreferences.setDouble('volume', 0.7);
    expect(await sharedPreferences.getDouble('volume'), 0.7);
    verify(() => sharedPreferences.setDouble('volume', 0.7)).called(1);
  });
}
