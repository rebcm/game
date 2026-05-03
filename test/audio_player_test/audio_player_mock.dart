import 'package:audioplayers/audioplayers.dart';
import 'package:mockito/mockito.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

class FakeAudioPlayerSource extends Fake implements AudioPlayerSource {
  @override
  String get url => 'fake_url';
}

void setupAudioPlayerMock(MockAudioPlayer audioPlayerMock) {
  when(audioPlayerMock.setVolume(any)).thenAnswer((_) async => 1);
  when(audioPlayerMock.setReleaseMode(any)).thenAnswer((_) async => {});
  when(audioPlayerMock.play(any, mode: anyNamed('mode'))).thenAnswer((_) async => {});
  when(audioPlayerMock.stop()).thenAnswer((_) async => {});
  when(audioPlayerMock.pause()).thenAnswer((_) async => {});
  when(audioPlayerMock.resume()).thenAnswer((_) async => {});
  when(audioPlayerMock.release()).thenAnswer((_) async => {});
  when(audioPlayerMock.getCurrentPosition()).thenAnswer((_) async => Duration.zero);
  when(audioPlayerMock.getDuration()).thenAnswer((_) async => Duration.zero);
}
