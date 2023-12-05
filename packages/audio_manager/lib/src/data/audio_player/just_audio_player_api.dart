import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_manager/src/data/data.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class JustAudioPlayerApi extends AudioPlayerApi {
  final AudioPlayer _audioPlayer = AudioPlayer();

  JustAudioPlayerApi() {
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _audioPlayerCompleteController.add(true);
      }
    });
  }

  final StreamController<bool> _audioPlayerCompleteController =
      StreamController<bool>.broadcast();

  @override
  Stream<bool> get audioPlayerCompleteStream =>
      _audioPlayerCompleteController.stream;

  @override
  Future<void> playAudioFromBytes(Uint8List audioBytes) async {
    final filePath = await _saveAudioToFile(audioBytes);
    await playAudioFromFile(filePath);
  }

  Future<String> _saveAudioToFile(Uint8List audioBytes) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentsDirectory.path}/audio_file.mp3';

    final file = File(filePath);
    await file.writeAsBytes(audioBytes);

    return filePath;
  }

  @override
  Future<void> playAudioFromFile(String filePath) async {
    await _audioPlayer.setFilePath(filePath);
    await _audioPlayer.play();
  }

  @override
  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> dispose() async {
    await _audioPlayerCompleteController.close();
    await _audioPlayer.dispose();
  }
}