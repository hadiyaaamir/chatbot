part of 'widgets.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({super.key});

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  List<File> messages = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<ChatbotBloc>().add(
                      state.isRecordingMessage
                          ? ChatbotMessageRecordingStopped()
                          : ChatbotMessageRecordingStarted(),
                    );
              },
              shape: const CircleBorder(),
              mini: true,
              child: Icon(state.isRecordingMessage ? Icons.pause : Icons.mic),
            ),
          ],
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final audioManager = context.read<AudioManager>();
    return GestureDetector(
      onTap: () => audioManager.playAudioFromFile(path),
      child: const Icon(Icons.play_arrow),
    );
  }
}
