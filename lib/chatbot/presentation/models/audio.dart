part of 'models.dart';

class Audio extends Equatable {
  const Audio({required this.audio, this.isPlaying = false});

  final String audio;
  final bool isPlaying;

  Audio startPlaying() => copyWith(isPlaying: true);
  Audio stopPlaying() => copyWith(isPlaying: false);

  Audio copyWith({String? audio, bool? isPlaying}) {
    return Audio(
      audio: audio ?? this.audio,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [audio, isPlaying];
}
