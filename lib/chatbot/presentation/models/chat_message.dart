part of 'models.dart';

class ChatMessage extends Equatable {
  const ChatMessage(this.message, {this.sentMessage = true});

  final bool sentMessage;
  final String message;

  @override
  List<Object?> get props => [message, sentMessage];
}
