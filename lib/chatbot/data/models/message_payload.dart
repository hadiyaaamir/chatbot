part of 'models.dart';

class MessagePayload extends Equatable {
  const MessagePayload(this.text, {this.suggestions = const []});

  final String text;
  final List<ChatSuggestion> suggestions;

  factory MessagePayload.fromJson(Map<String, dynamic> json) {
    List<ChatSuggestion> suggestions = [];

    if (json['suggestions'] != null) {
      suggestions = List<ChatSuggestion>.from(
        (json['suggestions'] as List<dynamic>).map(
          (suggestionJson) => ChatSuggestion.fromJson(
            suggestionJson as Map<String, dynamic>,
          ),
        ),
      );
    }

    return MessagePayload(
      json['text'] as String? ?? '',
      suggestions: suggestions,
    );
  }

  @override
  List<Object> get props => [text, suggestions];
}
