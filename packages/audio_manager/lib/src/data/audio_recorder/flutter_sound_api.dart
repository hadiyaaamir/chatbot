import 'package:audio_manager/src/data/data.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterSoundApi extends AudioRecorderApi {
  late final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  late String lastRecordedFilePath;

  @override
  Future<void> initialise() async {
    await Permission.microphone.request();
    await Permission.storage.request();

    await _recorder.openRecorder();
  }

  @override
  Future<void> startRecoding() async {
    if (_recorder.isRecording) return;

    String directory = (await getTemporaryDirectory()).path;
    String timestamp = DateTime.now().toIso8601String();
    final filePath = '$directory/audio_record_$timestamp.wav';

    lastRecordedFilePath = filePath;
    await _recorder.startRecorder(toFile: filePath, codec: Codec.pcm16WAV);
  }

  @override
  Future<String?> stopRecording() async {
    await _recorder.stopRecorder();
    return lastRecordedFilePath;
  }

  @override
  Future<void> dispose() async {
    _recorder.closeRecorder();
  }

  @override
  bool get isRecording => _recorder.isRecording;
}
