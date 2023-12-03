part of 'audio_manager.dart';

class AudioManagerImpl extends AudioManager {
  AudioManagerImpl({super.audioPlayerApi, super.audioRecorderApi});

  @override
  Uint8List? stringToByte(String? outputAudio) {
    return outputAudio != null ? base64.decode(outputAudio) : null;
  }

  @override
  Future<void> initialise() async {
    await audioRecorderApi.initialise();
  }

  @override
  Future<String> audioFromPath(String filePath) async {
    final fileBytes = await File(filePath).readAsBytes();
    return base64.encode(fileBytes);
  }

  @override
  Future<void> playAudioFromBytes(Uint8List audioBytes) async {
    await audioPlayerApi.playAudioFromBytes(audioBytes);
  }

  @override
  Future<void> playAudioFromFile(String filePath) async {
    await audioPlayerApi.playAudioFromFile(filePath);
  }

  @override
  Future<void> pauseAudio() async {
    await audioPlayerApi.pauseAudio();
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
  bool get isRecording => audioRecorderApi.isRecording;

  @override
  Future<void> dispose() async {
    await audioRecorderApi.dispose();
  }
}
