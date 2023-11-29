import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<ChatbotBloc, ChatbotState>(
          builder: (context, state) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) => MessageBubble(
                message: state.messages[index],
              ),
              itemCount: state.messages.length,
            );
          },
        ),
      ),
    );
  }
}
