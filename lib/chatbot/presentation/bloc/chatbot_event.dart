part of 'chatbot_bloc.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object> get props => [];
}

class ChatbotMessageSent extends ChatbotEvent {
  const ChatbotMessageSent({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
