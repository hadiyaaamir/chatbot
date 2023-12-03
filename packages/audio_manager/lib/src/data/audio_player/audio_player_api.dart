import 'dart:typed_data';

export 'just_audio_player_api.dart';

abstract class AudioPlayerApi {
  Future<void> playAudioFromBytes(Uint8List audioBytes);
  Future<void> playAudioFromFile(String filePath);
  Future<void> pauseAudio();
}
