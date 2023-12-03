export 'flutter_sound_api.dart';

abstract class AudioRecorderApi {
  Future<void> initialise();

  Future<void> startRecoding();
  Future<String?> stopRecording();

  bool get isRecording;

  Future<void> dispose();
}
