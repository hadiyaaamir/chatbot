import 'package:flutter/material.dart';
import 'package:chatbot/chatbot/chatbot.dart';

class ChatbotBody extends StatelessWidget {
  const ChatbotBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
