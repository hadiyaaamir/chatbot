import 'dart:typed_data';

export 'just_audio_player_api.dart';

abstract class AudioPlayerApi {
  Stream<bool> get audioPlayerCompleteStream;

  Future<void> playAudioFromBytes(Uint8List audioBytes);
  Future<void> playAudioFromFile(String filePath);
  Future<void> pauseAudio();

  Duration get duration;
  Stream<Duration> get position;
  Future<void> seek({required Duration position});

  Future<void> dispose();
}
