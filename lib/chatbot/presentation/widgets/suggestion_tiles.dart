import 'package:chatbot/chatbot/chatbot.dart';
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
                        return _SuggestionTile(
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

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({
    required this.suggestion,
    required this.usernameRequired,
  });

  final ChatSuggestion suggestion;
  final bool usernameRequired;

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
        ),
        child: Text(
          suggestion.tileText,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onPressed: () => context.read<ChatbotBloc>().add(
              ChatbotMessageSent(
                attachUsername: usernameRequired,
                message: ChatMessage(
                  message: MessagePayload(text: suggestion.messageText),
                ),
              ),
            ),
      ),
    );
  }
}
