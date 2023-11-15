part of 'chatbot_bloc.dart';


class ChatbotState extends Equatable {

  const ChatbotState({
    this.customProperty = 'Default Value',
  });

  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  ChatbotState copyWith({
    String? customProperty,
  }) {
    return ChatbotState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}


class ChatbotInitial extends ChatbotState {
  const ChatbotInitial() : super();
}
