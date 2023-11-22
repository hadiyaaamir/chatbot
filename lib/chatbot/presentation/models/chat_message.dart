part of 'models.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    this.sentMessage = true,
    required this.message,
    this.displayText,
  });

  final bool sentMessage;
  final MessagePayload message;
  final String? displayText;

  @override
  List<Object?> get props => [sentMessage, message];
}
