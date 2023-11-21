part of 'models.dart';

class ChatSuggestion extends Equatable {
  const ChatSuggestion({required this.tileText, String? messageText})
      : messageText = messageText ?? tileText;

  final String tileText;
  final String messageText;

  factory ChatSuggestion.fromJson(Map<String, dynamic> json) {
    return ChatSuggestion(
      tileText: json['tileText'] as String? ?? '',
      messageText: json['messageText'] as String?,
    );
  }

  @override
  List<Object?> get props => [tileText, messageText];
}
