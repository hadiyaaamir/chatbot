import 'package:chatbot/chatbot/chatbot.dart';

import 'package:flutter/material.dart';

class SuggestionMessages extends StatelessWidget {
  const SuggestionMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SuggestionTile(
          suggestion: ChatSuggestion(
            tileText: 'I want to book tickets for an event',
          ),
          navigateToChatbot: true,
        ),
        SizedBox(height: 2),
        SuggestionTile(
          usernameRequired: true,
          suggestion: ChatSuggestion(
            tileText: 'I want to view my booked tickets',
          ),
          navigateToChatbot: true,
        ),
        SizedBox(height: 2),
        SuggestionTile(
          suggestion: ChatSuggestion(
            tileText: 'I want more information about an event',
          ),
          navigateToChatbot: true,
        ),
      ],
    );
  }
}
