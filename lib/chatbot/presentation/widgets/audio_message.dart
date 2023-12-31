part of 'message_bubble.dart';

class _AudioMessage extends StatelessWidget {
  const _AudioMessage({required this.message});

  final MessagePayload message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PlayPauseIcon(message: message),
        const SizedBox(width: 5),
        _AudioProgressIndicator(isPlaying: message.audio!.isPlaying)
      ],
    );
  }
}

class _PlayPauseIcon extends StatelessWidget {
  const _PlayPauseIcon({required this.message});

  final MessagePayload message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ChatbotBloc>().add(
            message.audio!.isPlaying
                ? ChatbotAudioMessageStopped(message: message)
                : ChatbotAudioMessagePlayed(message: message),
          ),
      child: Icon(
        message.audio!.isPlaying ? Icons.pause : Icons.play_arrow,
        color: Theme.of(context).colorScheme.onPrimary,
        size: Theme.of(context).textTheme.bodyLarge?.fontSize,
      ),
    );
  }
}

class _AudioProgressIndicator extends StatelessWidget {
  const _AudioProgressIndicator({required this.isPlaying});

  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final AudioManager audioManager = context.read<AudioManager>();

    final currentPositionStream = audioManager.currentAudioPosition;
    final duration = audioManager.currentAudioDuration.inMilliseconds;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder(
      stream: currentPositionStream,
      builder: (context, snapshot) {
        final currentPosition = (snapshot.data ?? Duration.zero).inMilliseconds;
        final progress = currentPosition / duration;

        return isPlaying && duration != 0
            ? GestureDetector(
                onTapDown: (details) {
                  final tappedWidth = details.localPosition.dx;
                  final indicatorWidth = context.size!.width;
                  final double seekPosition = tappedWidth / indicatorWidth;

                  final Duration seekTime = Duration(
                    milliseconds: (seekPosition * duration).round(),
                  );

                  audioManager.currentAudioSeek(position: seekTime);
                },
                child: SizedBox(
                  width: 100,
                  height: 3,
                  child: LinearProgressIndicator(
                    value: progress,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                    backgroundColor: colorScheme.inversePrimary,
                  ),
                ),
              )
            : Container(
                width: 100,
                height: 3,
                color: colorScheme.inversePrimary,
              );
      },
    );
  }
}
