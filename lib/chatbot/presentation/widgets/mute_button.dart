import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      buildWhen: (previous, current) => previous.isMuted != current.isMuted,
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.read<ChatbotBloc>().add(
                ChatbotMuteToggled(),
              ),
          icon: Icon(
            state.isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
          ),
        );
      },
    );
  }
}
