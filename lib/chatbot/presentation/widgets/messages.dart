import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener<ChatbotBloc, ChatbotState>(
        listenWhen: (previous, current) =>
            previous.messages.length != current.messages.length &&
            current.messages.isNotEmpty &&
            current.messages.first.sentMessage,
        listener: (context, state) {
          scrollToBottom();
        },
        child: BlocBuilder<ChatbotBloc, ChatbotState>(
          builder: (context, state) {
            return ListView.builder(
              controller: _scrollController,
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

  void scrollToBottom() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
