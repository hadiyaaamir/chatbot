import 'package:chatbot/audio/audio.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class FlutterSoundApi extends AudioRecorderApi {
  late final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  Future<void> startRecoding() async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/audio_file.aac';

    await _recorder.startRecorder(toFile: filePath, codec: Codec.aacADTS);
  }

  @override
  Future<String?> stopRecording() async {
    return await _recorder.stopRecorder();
  }
}
