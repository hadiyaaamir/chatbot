import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot/audio/data/audio_player/audio_player_api.dart';

part 'audio_manager_impl.dart';

abstract class AudioManager {
  AudioManager({AudioPlayerApi? audioPlayerApi})
      : audioPlayerApi = audioPlayerApi ?? JustAudioPlayerApi();

  final AudioPlayerApi audioPlayerApi;

  Future<void> playAudio(Uint8List audioBytes);

  static Uint8List? stringToByte(String? outputAudio) {
    return outputAudio != null ? base64.decode(outputAudio) : null;
  }
}
