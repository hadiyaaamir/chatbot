part of 'audio_manager.dart';

class AudioManagerImpl extends AudioManager {
  AudioManagerImpl({super.audioPlayerApi});

  @override
  Future<void> playAudio(Uint8List audioBytes) async {
    await audioPlayerApi.playAudio(audioBytes);
  }
}
