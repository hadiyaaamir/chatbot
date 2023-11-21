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
      child: Stack(
        children: [
          TextField(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  context.read<ChatbotBloc>().add(
                        ChatbotMessageSent(message: _messageController.text),
                      );
                  _messageController.clear();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
