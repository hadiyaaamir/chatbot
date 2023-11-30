export 'flutter_sound_api.dart';

abstract class AudioRecorderApi {
  Future<void> startRecoding();
  Future<String?> stopRecording();
}
