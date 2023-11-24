part of 'models.dart';

class ChatSuggestion extends Equatable {
  const ChatSuggestion({
    required this.tileText,
    String? messageText,
    String? sendMessageText,
  })  : messageText = messageText ?? tileText,
        sendMessageText = sendMessageText ?? messageText ?? tileText;

  final String tileText;
  final String messageText;
  final String sendMessageText;

  factory ChatSuggestion.fromJson(Map<String, dynamic> json) {
    return ChatSuggestion(
      tileText: json['tileText'] as String? ?? '',
      messageText: json['messageText'] as String?,
    );
  }

  @override
  List<Object?> get props => [tileText, messageText];
}
