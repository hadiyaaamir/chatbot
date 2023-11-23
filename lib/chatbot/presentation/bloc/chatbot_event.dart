part of 'chatbot_bloc.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object> get props => [];
}

class ChatbotSubscription extends ChatbotEvent {}

class ChatbotMessageSent extends ChatbotEvent {
  const ChatbotMessageSent({
    required this.message,
    this.attachUsername = false,
  });
  final ChatMessage message;
  final bool attachUsername;

  @override
  List<Object> get props => [message];
}
