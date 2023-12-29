import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_manager/src/data/data.dart';

part 'audio_manager_impl.dart';

abstract class AudioManager {
  AudioManager(
      {AudioPlayerApi? audioPlayerApi, AudioRecorderApi? audioRecorderApi})
      : audioPlayerApi = audioPlayerApi ?? JustAudioPlayerApi(),
        audioRecorderApi = audioRecorderApi ?? FlutterSoundApi();

  final AudioPlayerApi audioPlayerApi;
  final AudioRecorderApi audioRecorderApi;

  Future<void> initialise();
  Future<void> dispose();

  Stream<bool> get audioPlayerCompleteStream;

  Future<void> playAudioFromString(String audio);
  Future<void> playAudioFromBytes(Uint8List audioBytes);
  Future<void> playAudioFromFile(String filePath);
  Future<void> pauseAudio();

  Future<void> startRecording();
  Future<String?> stopRecording();
  bool get isRecording;

  Uint8List? stringToByte(String? outputAudio);
  Future<String> audioFromPath(String filePath);
}
