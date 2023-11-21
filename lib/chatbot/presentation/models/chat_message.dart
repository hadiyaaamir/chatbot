part of 'models.dart';

class ChatMessage extends Equatable {
  const ChatMessage({this.sentMessage = true, required this.message});

  final bool sentMessage;
  final MessagePayload message;

  @override
  List<Object?> get props => [sentMessage, message];
}
