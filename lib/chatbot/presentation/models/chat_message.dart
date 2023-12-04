part of 'models.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    this.sentMessage = true,
    required this.message,
  });

  final bool sentMessage;
  final MessagePayload message;

  ChatMessage playAudio() => copyWith(message: message.playAudio());
  ChatMessage stopAudio() => copyWith(message: message.stopAudio());

  ChatMessage copyWith({MessagePayload? message, bool? sentMessage}) {
    return ChatMessage(
      message: message ?? this.message,
      sentMessage: sentMessage ?? this.sentMessage,
    );
  }

  @override
  List<Object?> get props => [sentMessage, message];
}
