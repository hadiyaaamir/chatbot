part of 'chatbot_bloc.dart';

class ChatbotState extends Equatable {
  const ChatbotState({
    this.messages = const [],
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
