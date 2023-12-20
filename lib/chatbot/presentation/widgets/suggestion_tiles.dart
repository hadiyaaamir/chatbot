import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/navigation/navigation.dart';
import 'package:flutter/material.dart';

class SuggestionTiles extends StatelessWidget {
  const SuggestionTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return state.messages.isEmpty
            ? const SizedBox(height: 0)
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: List.generate(
                      state.messages.first.message.suggestions.length,
                      (index) {
                        final message = state.messages.first.message;
                        return SuggestionTile(
                          suggestion: message.suggestions[index],
                          usernameRequired: message.requireUsername,
                        );
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({
    super.key,
    required this.suggestion,
    this.usernameRequired = false,
    this.navigateToChatbot = false,
  });

  final ChatSuggestion suggestion;
  final bool usernameRequired;

  final bool navigateToChatbot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          foregroundColor: Theme.of(context).colorScheme.onBackground,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        child: Text(suggestion.tileText),
        onPressed: () {
          if (navigateToChatbot) {
            context.read<NavigationBloc>().add(
                  NavigationIndexChanged(
                    selectedIndex: NavigablePages.chat.index,
                  ),
                );
          }
          context.read<ChatbotBloc>().add(
                ChatbotMessageSent(
                  attachUsername: usernameRequired,
                  message: ChatMessage(
                    message: MessagePayload(
                      text: suggestion.sendMessageText,
                      displayText: suggestion.messageText,
                    ),
                  ),
                ),
              );
        },
      ),
    );
  }
}
