export 'flutter_sound_api.dart';

abstract class AudioRecorderApi {
  Future<void> initialise();

  Future<void> startRecoding();
  Future<String?> stopRecording();

  Future<void> dispose();
}
