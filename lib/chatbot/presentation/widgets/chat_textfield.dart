import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class ChatTextfield extends StatefulWidget {
  const ChatTextfield({super.key});

  @override
  State<ChatTextfield> createState() => _ChatTextfieldState();
}

class _ChatTextfieldState extends State<ChatTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: BlocBuilder<ChatbotBloc, ChatbotState>(
        builder: (context, state) {
          final enabled = state.messages.isEmpty
              ? true
              : !state.messages.first.message.onlySuggestions;

          final attachUsername = state.messages.isEmpty
              ? false
              : state.messages.first.message.requireUsername;

          return Row(
            children: [
              Expanded(
                child: _TextEntryArea(
                  enabled: enabled,
                  attachUsername: attachUsername,
                ),
              ),
              const SizedBox(width: 5),
              const _RecordingButton(),
            ],
          );
        },
      ),
    );
  }
}

class _TextEntryArea extends StatefulWidget {
  const _TextEntryArea({
    required this.enabled,
    required this.attachUsername,
  });

  final bool enabled;
  final bool attachUsername;

  @override
  State<_TextEntryArea> createState() => _TextEntryAreaState();
}

class _TextEntryAreaState extends State<_TextEntryArea> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
      enabled: widget.enabled,
      controller: _messageController,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Message',
        suffixIcon: _SendButton(
          enabled: widget.enabled,
          attachUsername: widget.attachUsername,
          messageController: _messageController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.enabled,
    required this.attachUsername,
    required this.messageController,
  });

  final bool enabled;
  final bool attachUsername;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: enabled
          ? () {
              context.read<ChatbotBloc>().add(
                    ChatbotMessageSent(
                      attachUsername: attachUsername,
                      message: ChatMessage(
                        message: MessagePayload(text: messageController.text),
                      ),
                    ),
                  );
              messageController.clear();
            }
          : null,
      icon: const Icon(Icons.send),
    );
  }
}

class _RecordingButton extends StatelessWidget {
  const _RecordingButton();

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
