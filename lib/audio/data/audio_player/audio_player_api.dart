import 'dart:io';
import 'dart:typed_data';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

part 'just_audio_player_api.dart';

abstract class AudioPlayerApi {
  Future<void> playAudio(Uint8List audioBytes);
}
