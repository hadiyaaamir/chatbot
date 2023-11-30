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
    final audioManager = context.read<AudioManager>();

    return ElevatedButton.icon(
      icon: isRecording ? const Icon(Icons.pause) : const Icon(Icons.mic),
      label: Text(isRecording ? 'Pause' : 'Record'),
      onPressed: () async {
        if (isRecording) {
          final result = await audioManager.stopRecording();
          print(result);
        } else {
          await audioManager.startRecording();
        }

        setState(() {
          isRecording = !isRecording;
        });
      },
    );
  }
}
