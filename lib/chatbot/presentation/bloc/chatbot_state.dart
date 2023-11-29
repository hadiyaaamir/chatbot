part of 'chatbot_bloc.dart';

enum ChatbotStatus { initial, loading, success, failure }

class ChatbotState extends Equatable {
  const ChatbotState({required this.messages, required this.status});

  final List<ChatMessage> messages;
  final ChatbotStatus status;

  @override
  List<Object> get props => [messages];

  ChatbotState copyWith({List<ChatMessage>? messages, ChatbotStatus? status}) {
    return ChatbotState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
    );
  }
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial()
      : super(messages: const [], status: ChatbotStatus.initial);
}
