part of 'chatbot_bloc.dart';

class ChatbotState extends Equatable {
  const ChatbotState({
    this.messages = const [
      ChatMessage(
        'Welcome to the Event Ticket Booking System. What would you like to do today?',
        sentMessage: false,
        suggestions: [
          ChatSuggestion(tileText: 'Get a list of Events'),
          ChatSuggestion(tileText: 'Book a Ticket for an event'),
          ChatSuggestion(tileText: 'Fake suggestion'),
        ],
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
