part of 'widgets.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({super.key});

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    // final audioManager = context.read<AudioManager>();

    return FloatingActionButton(
      onPressed: () {
        setState(() => isRecording = !isRecording);
      },
      shape: const CircleBorder(),
      mini: true,
      child: Icon(isRecording ? Icons.mic_none : Icons.mic),
    );
  }
}
