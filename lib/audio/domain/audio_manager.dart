import 'dart:convert';
import 'dart:typed_data';

import 'package:chatbot/audio/audio.dart';

part 'audio_manager_impl.dart';

abstract class AudioManager {
  AudioManager(
      {AudioPlayerApi? audioPlayerApi, AudioRecorderApi? audioRecorderApi})
      : audioPlayerApi = audioPlayerApi ?? JustAudioPlayerApi(),
        audioRecorderApi = audioRecorderApi ?? FlutterSoundApi();

  final AudioPlayerApi audioPlayerApi;
  final AudioRecorderApi audioRecorderApi;

  Future<void> playAudioFromBytes(Uint8List audioBytes);
  Future<void> playAudioFromFile(String filePath);
  Future<void> startRecording();
  Future<String?> stopRecording();

  Uint8List? stringToByte(String? outputAudio) {
    return outputAudio != null ? base64.decode(outputAudio) : null;
  }
}
