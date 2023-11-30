part of 'audio_manager.dart';

class AudioManagerImpl extends AudioManager {
  AudioManagerImpl({super.audioPlayerApi, super.audioRecorderApi});

  @override
  Future<void> playAudio(Uint8List audioBytes) async {
    await audioPlayerApi.playAudio(audioBytes);
  }

  @override
  Future<void> startRecording() async {
    await audioRecorderApi.startRecoding();
  }

  @override
  Future<String?> stopRecording() async {
    return await audioRecorderApi.stopRecording();
  }
}
