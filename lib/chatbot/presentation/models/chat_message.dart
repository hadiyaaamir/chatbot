part of 'models.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    this.sentMessage = true,
    required this.message,
  });

  final bool sentMessage;
  final MessagePayload message;

  static const List<ChatMessage> initialMessages = [
    ChatMessage(
      message: MessagePayload(
        'Welcome to the Event Ticket Booking System. What would you like to do today?',
        suggestions: [
          ChatSuggestion(
            tileText: 'Book tickets for an event',
            messageText: 'I want to book tickets for an event',
          ),
          ChatSuggestion(
            tileText: 'View my tickets',
            messageText: 'I want to view my tickets',
          )
        ],
      ),
      sentMessage: false,
    ),
  ];

  @override
  List<Object?> get props => [sentMessage, message];
}
