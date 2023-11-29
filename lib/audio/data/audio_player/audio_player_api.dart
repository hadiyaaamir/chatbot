import 'dart:typed_data';

export 'just_audio_player_api.dart';

abstract class AudioPlayerApi {
  Future<void> playAudio(Uint8List audioBytes);
}
