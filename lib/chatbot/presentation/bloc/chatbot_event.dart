part of 'chatbot_bloc.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object> get props => [];

}

class ChatbotCustomEvent extends ChatbotEvent {
  const ChatbotCustomEvent({required this.property});
  final String property;

  @override
  List<Object> get props => [property];
}