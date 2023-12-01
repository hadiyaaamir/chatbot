part of 'audio_manager.dart';

class AudioManagerImpl extends AudioManager {
  AudioManagerImpl({super.audioPlayerApi, super.audioRecorderApi});

  @override
  Future<void> initialise() async {
    await audioRecorderApi.initialise();
  }

  @override
  Future<void> playAudioFromBytes(Uint8List audioBytes) async {
    await audioPlayerApi.playAudioFromBytes(audioBytes);
  }

  @override
  Future<void> startRecording() async {
    await audioRecorderApi.startRecoding();
  }

  @override
  Future<String?> stopRecording() async {
    return await audioRecorderApi.stopRecording();
  }

  @override
  Future<void> playAudioFromFile(String filePath) async {
    await audioPlayerApi.playAudioFromFile(filePath);
  }

  @override
  Future<void> dispose() async {
    await audioRecorderApi.dispose();
  }
}
