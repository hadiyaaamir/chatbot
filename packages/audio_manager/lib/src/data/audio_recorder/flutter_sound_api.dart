import 'package:audio_manager/src/data/data.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterSoundApi extends AudioRecorderApi {
  late final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  Future<void> initialise() async {
    await Permission.microphone.request();
    await Permission.manageExternalStorage.request();
    await Permission.audio.request();
    await Permission.mediaLibrary.request();

    await _recorder.openRecorder();
  }

  @override
  Future<void> startRecoding() async {
    if (_recorder.isRecording) return;

    final tempDir = await getTemporaryDirectory();

    String timestamp = DateTime.now().toIso8601String();
    final filePath = '${tempDir.path}/audio_record_$timestamp.wav';

    await _recorder.startRecorder(toFile: filePath, codec: Codec.pcm16WAV);
  }

  @override
  Future<String?> stopRecording() async {
    final output = await _recorder.stopRecorder();
    return output;
  }

  @override
  Future<void> dispose() async {
    _recorder.closeRecorder();
  }

  @override
  bool get isRecording => _recorder.isRecording;
}
