part of 'audio_player_api.dart';

class JustAudioPlayerApi extends AudioPlayerApi {
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
