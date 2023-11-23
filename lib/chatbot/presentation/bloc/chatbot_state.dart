part of 'chatbot_bloc.dart';

class ChatbotState extends Equatable {
  const ChatbotState({
    this.messages = const [
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
    ],
  });

  final List<ChatMessage> messages;

  @override
  List<Object> get props => [messages];

  ChatbotState copyWith({
    List<ChatMessage>? messages,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
    );
  }
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial() : super();
}
