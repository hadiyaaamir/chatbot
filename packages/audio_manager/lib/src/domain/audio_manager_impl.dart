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
  Stream<bool> get audioPlayerCompleteStream {
    return audioPlayerApi.audioPlayerCompleteStream;
  }

  @override
  Future<void> playAudioFromString(String audio) async {
    final audioBytes = stringToByte(audio);
    if (audioBytes != null) await playAudioFromBytes(audioBytes);
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
  Duration get currentAudioDuration => audioPlayerApi.duration;

  @override
  Stream<Duration> get currentAudioPosition => audioPlayerApi.position;

  @override
  Future<void> currentAudioSeek({required Duration position}) async {
    await audioPlayerApi.seek(position: position);
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
    Future.wait([
      audioPlayerApi.dispose(),
      audioRecorderApi.dispose(),
    ]);
  }
}
