import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class ChatTextfield extends StatefulWidget {
  const ChatTextfield({super.key});

  @override
  State<ChatTextfield> createState() => _ChatTextfieldState();
}

class _ChatTextfieldState extends State<ChatTextfield> {
  final TextEditingController _messageController = TextEditingController();

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

          return Stack(
            children: [
              _TextEntryArea(
                enabled: enabled,
                messageController: _messageController,
              ),
              _SendButton(
                attachUsername: attachUsername,
                messageController: _messageController,
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class _TextEntryArea extends StatelessWidget {
  const _TextEntryArea({
    required this.enabled,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final bool enabled;
  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: _messageController,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.attachUsername,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final bool attachUsername;
  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            context.read<ChatbotBloc>().add(
                  ChatbotMessageSent(
                    attachUsername: attachUsername,
                    message: ChatMessage(
                      message: MessagePayload(_messageController.text),
                    ),
                  ),
                );
            _messageController.clear();
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
