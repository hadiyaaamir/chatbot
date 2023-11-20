part of 'models.dart';

class ChatMessage extends Equatable {
  const ChatMessage(
    this.text, {
    this.sentMessage = true,
    this.suggestions = const [],
  });

  final bool sentMessage;
  final String text;
  final List<ChatSuggestion> suggestions;

  @override
  List<Object?> get props => [text, sentMessage, suggestions];
}
