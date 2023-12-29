part of 'models.dart';

class Audio extends Equatable {
  const Audio({
    required this.audio,
    this.isPlaying = false,
    this.duration = Duration.zero,
  });

  final String audio;
  final bool isPlaying;

  final Duration duration;

  Audio startPlaying() => copyWith(isPlaying: true);
  Audio stopPlaying() => copyWith(isPlaying: false);

  Audio copyWith({
    String? audio,
    bool? isPlaying,
    Duration? duration,
    Duration? currentPosition,
  }) {
    return Audio(
      audio: audio ?? this.audio,
      isPlaying: isPlaying ?? this.isPlaying,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object> get props => [audio, isPlaying, duration];
}
