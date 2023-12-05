import 'package:audio_manager/src/data/data.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class FlutterSoundApi extends AudioRecorderApi {
  late final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  Future<void> initialise() async {
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
    return await _recorder.stopRecorder();
  }

  @override
  Future<void> dispose() async {
    _recorder.closeRecorder();
  }

  @override
  bool get isRecording => _recorder.isRecording;
}
