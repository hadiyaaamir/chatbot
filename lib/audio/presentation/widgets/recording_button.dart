part of 'widgets.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({super.key});

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  bool isRecording = false;

  List<File> messages = [];

  @override
  Widget build(BuildContext context) {
    final audioManager = context.read<AudioManager>();

    return Row(
      children: [
        FloatingActionButton(
          onPressed: () async {
            if (isRecording) {
              final output = await audioManager.stopRecording();

              if (output != null) {
                if (mounted) {
                  context.read<ChatbotBloc>().add(
                        ChatbotMessageSent(
                          message: ChatMessage(
                            message: MessagePayload(audio: output),
                          ),
                        ),
                      );
                }
              }
            } else {
              await audioManager.startRecording();
            }

            setState(() {
              isRecording = !isRecording;
            });
          },
          shape: const CircleBorder(),
          mini: true,
          child: Icon(isRecording ? Icons.pause : Icons.mic),
        ),
      ],
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
