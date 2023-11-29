import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

abstract class AudioManager {
  Future<void> playAudio(Uint8List audioBytes);

  static Uint8List? stringToByte(String? outputAudio) {
    return outputAudio != null ? base64.decode(outputAudio) : null;
  }
}

class AudioManagerImpl extends AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> playAudio(Uint8List audioBytes) async {
    final filePath = await _saveAudioToFile(audioBytes);
    await _audioPlayer.setFilePath(filePath);
    await _audioPlayer.play();
  }

  Future<String> _saveAudioToFile(Uint8List audioBytes) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentsDirectory.path}/audio_file.mp3';

    final file = File(filePath);
    await file.writeAsBytes(audioBytes);

    return filePath;
  }
}
