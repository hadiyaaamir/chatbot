import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class SuggestionTiles extends StatelessWidget {
  const SuggestionTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return state.messages.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: List.generate(
                      state.messages.first.suggestions.length,
                      (index) => _SuggestionTile(
                        suggestion: state.messages.first.suggestions[index],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({required this.suggestion});

  final ChatSuggestion suggestion;

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
        onPressed: () {
          context
              .read<ChatbotBloc>()
              .add(ChatbotMessageSent(message: suggestion.messageText));
        },
      ),
    );
  }
}
